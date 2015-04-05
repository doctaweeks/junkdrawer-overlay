# @ECLASS: dlang.eclass
# @MAINTAINER: marco.leise@gmx.de
# @BLURB:
# install D libraries in multiple locations for each D version and compiler
# @DESCRIPTION:
# The dlang eclass faciliates creating dependiencies on D libraries for use
# with different D compilers and D versions.

if [[ ${___ECLASS_ONCE_DLANG} != "recur -_+^+_- spank" ]] ; then
___ECLASS_ONCE_DLANG="recur -_+^+_- spank"

if has ${EAPI:-0} 0 1 2 3; then
	die "EAPI must be >= 4 for dlang packages."
fi

inherit flag-o-matic versionator dlang-compilers
if [[ "${DLANG_PACKAGE_TYPE}" == "multi" ]]; then
	# We handle a multi instance package.
	inherit multilib-minimal
fi

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test src_install


# Definition of know compilers and supported front-end versions from dlang-compilers.eclass

dlang-compilers_declare_versions


# The rest of the ebuild ...

export DLANG_IMPORT_DIR="usr/include/dlang"

dlang_convert_ldflags() {
	if [[ "${DLANG_VENDOR}" == "DigitalMars" ]] || [[ "${DLANG_VENDOR}" == "LDC" ]]; then
		local set repl flags=()
		if [[ is_dmd ]]; then
			repl="-L"
		elif [[ is_ldc ]]; then
			repl="-L="
		fi
		for set in ${LDFLAGS}; do
			if [[ "${set:0:4}" == "-Wl," ]]; then
				set=${set/-Wl,/${repl}}
				flags+=(${set//,/ ${repl}})
			elif [[ "${set:0:9}" == "-Xlinker " ]]; then
				flags+=(${set/-Xlinker /${repl}})
			elif [[ "${set:0:2}" == "-L" ]]; then
				flags+=(${set/-L/${repl}})
			else
				flags+=(${set})
			fi
		done
		# gc-sections breaks executables for some versions of D.
		# See: https://issues.dlang.org/show_bug.cgi?id=879
		if [[ "${DLANG_VENDOR}" == "DigitalMars" ]]; then
			if version_is_at_least 2.068 $DLANG_VERSION; then
				echo "${flags[@]}"
			else
				echo "${flags[@]} ${repl}--no-gc-sections"
			fi
		else
			echo "${flags[@]}"
		fi
	elif [[ "${DLANG_VENDOR}" == "GNU" ]]; then
		echo "${LDFLAGS}"
	else
		die "Set DLANG_VENDOR to DigitalMars, LDC or GNU prior to calling ${FUNCNAME}()."
	fi
}

__dlang_use_build_vars() {
	# Now we define some variables and then call the function.
	export ABI="$(echo ${MULTIBUILD_VARIANT} | cut -d- -f1)"
	export DC="$(echo ${MULTIBUILD_VARIANT} | cut -d- -f2)"
	export DC_VERSION="$(echo ${MULTIBUILD_VARIANT} | cut -d- -f3)"
	case "${DC:0:3}" in
		"dmd") export DLANG_VENDOR="DigitalMars" ;;
		"gdc") export DLANG_VENDOR="GNU" ;;
		"ldc") export DLANG_VENDOR="LDC" ;;
	esac
	export DLANG_VERSION="$(__dlang_compiler_to_dlang_version ${DC} ${DC_VERSION})"
	case "${ABI}" in
		"default") ;;
		"x86"*)    export MODEL=32 ;;
		*)         export MODEL=64 ;;
	esac
	if [[ "${DLANG_VENDOR}" == "DigitalMars" ]]; then
		export DC="/opt/${DC}-${DC_VERSION}/bin/dmd"
		export DMD="${DC}"
		export LIBDIR_${ABI}="../opt/dmd-${DC_VERSION}/lib${MODEL}"
		export DCFLAGS="${DMDFLAGS}"
		export DLANG_LINKER_FLAG="-L"
		export DLANG_SO_FLAGS="-shared -defaultlib=libphobos2.so -fPIC"
		export DLANG_OUTPUT_FLAG="-of"
	elif [[ "${DLANG_VENDOR}" == "GNU" ]]; then
		export DC="/usr/${__DLANG_CHOST}/gcc-bin/${DC_VERSION}/gdc"
		export DMD="/usr/${__DLANG_CHOST}/gcc-bin/${DC_VERSION}/gdmd"
		if [[ "${DLANG_PACKAGE_TYPE}" == "multi" ]] && multilib_is_native_abi; then
			export LIBDIR_${ABI}="lib/gcc/${__DLANG_CHOST}/${DC_VERSION}"
		else
			export LIBDIR_${ABI}="lib/gcc/${__DLANG_CHOST}/${DC_VERSION}/${MODEL}"
		fi
		export DCFLAGS="${GDCFLAGS}"
		export DLANG_LINKER_FLAG="-Xlinker "
		export DLANG_SO_FLAGS="-shared -fPIC"
		export DLANG_OUTPUT_FLAG="-o "
	elif [[ "${DLANG_VENDOR}" == "LDC" ]]; then
		export LIBDIR_${ABI}="../opt/${DC}-${DC_VERSION}/lib${MODEL}"
		export DMD="/opt/${DC}-${DC_VERSION}/bin/ldmd2"
		export DC="/opt/${DC}-${DC_VERSION}/bin/ldc2"
		# To allow separate compilation and avoid object file name collisions,
		# we append -oq (fully qualified module names for object file names).
		export DCFLAGS="${LDCFLAGS} -oq"
		export DLANG_LINKER_FLAG="-L="
		export DLANG_SO_FLAGS="-shared -relocation-model=pic"
		export DLANG_OUTPUT_FLAG="-of="
	else
		die "Could not detect D compiler vendor!"
	fi
	# We need to convert the LDFLAGS, so they are understood by DMD and LDC.
	LDFLAGS="$(dlang_convert_ldflags)" "${@}"
}

__dlang_prefix_words() {
	for arg in ${*:2}; do
		echo -n " $1$arg"
	done
}

__dlang_additional_flags() {
	# For info on debug use flags see:
	# https://wiki.gentoo.org/wiki/Project:Quality_Assurance/Backtraces#debug_USE_flag
	case "${DLANG_VENDOR}" in
		"DigitalMars")
			local version_prefix="-version="
			local import_prefix="-I"
			local debug_flags="-debug"
			;;
		"GNU")
			local version_prefix="-fversion="
			local import_prefix="-I"
			local debug_flags="-fdebug"
			;;
		"LDC")
			local version_prefix="-d-version="
			local import_prefix="-I="
			local debug_flags="-d-debug"
			;;
	esac
	echo $(has debug ${IUSE} && use debug && echo ${debug_flags})\
		$(__dlang_prefix_words $version_prefix $versions)\
		$(__dlang_prefix_words $import_prefix $imports)\
		$(__dlang_prefix_words "${DLANG_LINKER_FLAG}-l" $libs)
}


# @FUNCTION: dlang_foreach_config
# @DESCRIPTION:
# Function that calls its arguments for each D configuration. A few environment
# variables will be set for each call:
# ABI: See 'multilib_get_enabled_abis' from multilib-build.eclass.
# MODEL: This is either 32 or 64.
# DLANG_VENDOR: Either DigitalMars, GNU or LDC.
# DC: D compiler command. E.g. dmd2.064, ldc2-0.12.0 or
#   /usr/x86_64-pc-linux-gnu/gcc-bin/4.8.1/x86_64-pc-linux-gnu-gdc
# DC_VERSION: Release version of the compiler. This is the version excluding any
#   Patch releases. So dmd 2.064.2 would still be 2.064. This version is used
#   to separate potentially incompatible ABIs and to create the library path.
#   Typical versions of gdc or ldc are 4.8.1 or 0.12.
# DLANG_VERSION: This differs from DC_VERSION in so far as it displays the
#   front-end or language specification version for every compiler. Since the
#   release of D1 it follows the scheme x.yyy and is as of writing at 2.064.
# DLANG_LINKER_FLAG: The command-line flag, the respective compiler understands
#   as a prefix for a single argument that should be passed to the linker.
#   dmd: -L, gdc: -Xlinker, ldc: -L=
# DLANG_LIB_DIR: The compiler and compiler version specific library directory.
# DLANG_IMPORT_DIR: This is actually set globally. Place includes in a
#   sub-directory.
dlang_foreach_config() {
	debug-print-function ${FUNCNAME} "${@}"

	local MULTIBUILD_VARIANTS=($(__dlang_build_configurations))

	multibuild_wrapper() {
		debug-print-function ${FUNCNAME} "${@}"

		# We need to reset CC, else when dmd calls it, the result is:
		# "x86_64-pc-linux-gnu-gcc -m32": No such file or directory
		if [[ -v CC ]]; then
			local __ORIGINAL_CC="${CC}"
		fi
		multilib_toolchain_setup "${ABI}"
		if [[ -v __ORIGINAL_CC ]]; then
			CC="${__ORIGINAL_CC}"
		else
			unset CC
		fi
		mkdir -p "${BUILD_DIR}" || die
		pushd "${BUILD_DIR}" >/dev/null || die
		__dlang_use_build_vars "${@}"
		popd >/dev/null || die
	}

	multibuild_parallel_foreach_variant multibuild_wrapper "${@}"
}

dlang_single_config() {
	debug-print-function ${FUNCNAME} "${@}"

	local MULTIBUILD_VARIANT=$(__dlang_build_configurations)

	__dlang_use_build_vars "${@}"
}

dlang_has_shared_lib_support() {
	if [[ "${DLANG_VENDOR}" == "DigitalMars" ]]; then
		[[ "$(get_major_version ${DLANG_VERSION})" -eq 2 ]] && [[ "$(get_after_major_version ${DLANG_VERSION})" -ge 063 ]]
	elif [[ "${DLANG_VENDOR}" == "GNU" ]]; then
		return 1
	elif [[ "${DLANG_VENDOR}" == "LDC" ]]; then
		return 1
	else
		die "Could not detect D compiler vendor!"
	fi
}


# @FUNCTION: dlang_src_prepare
# @DESCRIPTION:
# Create a single copy of the package sources for each enabled D configuration.
dlang_src_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	default_src_prepare

	if [[ "${DLANG_PACKAGE_TYPE}" == "multi" ]]; then
		local MULTIBUILD_VARIANTS=($(__dlang_build_configurations))
		multibuild_copy_sources
	fi
}

dlang_src_configure() {
	__dlang_phase_wrapper configure
}

dlang_src_compile() {
	__dlang_phase_wrapper compile
}

dlang_src_test() {
	__dlang_phase_wrapper test
}

dlang_src_install() {
	__dlang_phase_wrapper install
}

### Non-public helper functions ###

declare -a __dlang_compiler_iuse
declare -a __dlang_depends

__dlang_is_in_version_range() {
	# Check the version range
	local dlang_version=${1%% *}
	local compiler_keywords=${1:${#dlang_version}}
	local compiler_keyword package_keyword stability_satisfied
	if [[ -n "$2" ]]; then
		[[ ${dlang_version#*.} -lt ${2#*.} ]] && return 1
	fi
	if [[ -n "$3" ]]; then
		[[ ${dlang_version#*.} -gt ${3#*.} ]] && return 1
	fi
	# Check the stability requirements (package archs not prefixed with ~)
	for package_keyword in $KEYWORDS; do
		if [[ "${package_keyword:0:1}" != "~" ]]; then
			stability_satisfied=0
			for compiler_keyword in $compiler_keywords; do
				if [[ "$package_keyword" == "$compiler_keyword" ]]; then
					stability_satisfied=1
				fi
			done
			[[ $stability_satisfied -eq 1 ]] || return 1
		fi
	done
}

__dlang_filter_compilers() {
	local dc_version mapping iuse

	# filter for DMD
	for dc_version in ${!__dlang_dmd_frontend_mapping[@]}; do
		mapping=${__dlang_dmd_frontend_mapping[$dc_version]}
		if __dlang_is_in_version_range "$mapping" "$1" "$2" "$KEYWORDS"; then
			iuse=dmd-$(replace_all_version_separators _ $dc_version)
			__dlang_compiler_iuse+=("$iuse")
			if [[ "${DLANG_PACKAGE_TYPE}" == "single" ]]; then
				__dlang_depends+=("$iuse? ( dev-lang/dmd:$dc_version= )")
			else
				__dlang_depends+=("$iuse? ( dev-lang/dmd:$dc_version=[${MULTILIB_USEDEP}] )")
			fi
		fi
	done

	# GDC (doesn't support sub-slots, due to low EAPI requirement)
	for dc_version in ${!__dlang_gdc_frontend_mapping[@]}; do
		mapping=${__dlang_gdc_frontend_mapping[$dc_version]}
		if __dlang_is_in_version_range "$mapping" "$1" "$2" "$KEYWORDS"; then
			iuse=gdc-$(replace_all_version_separators _ $dc_version)
			__dlang_compiler_iuse+=("$iuse")
			__dlang_depends+=("$iuse? ( =sys-devel/gcc-${dc_version}*[d] )")
		fi
	done

	# filter for LDC2
	for dc_version in ${!__dlang_ldc2_frontend_mapping[@]}; do
		mapping=${__dlang_ldc2_frontend_mapping[$dc_version]}
		if __dlang_is_in_version_range "$mapping" "$1" "$2" "$KEYWORDS"; then
			iuse=ldc2-$(replace_all_version_separators _ $dc_version)
			__dlang_compiler_iuse+=("$iuse")
			__dlang_depends+=("$iuse? ( dev-lang/ldc2:${dc_version}= )")
		fi
	done
}

__dlang_filter_versions() {
	local range start stop matches d_version versions do_start
	local -A valid

	# Use given range to create a positive list of supported D versions
	if [[ -v DLANG_VERSION_RANGE ]]; then
		for range in $DLANG_VERSION_RANGE; do
			# Define start and stop of range
			if [[ "${range}" == *?- ]]; then
				start="${range%-}"
				stop=
			elif [[ "${range}" == -?* ]]; then
				start=
				stop="${range#-}"
			elif [[ "${range}" == *?-?* ]]; then
				start="$(echo "${range}" | cut -d- -f1)"
				stop="$(echo "${range}" | cut -d- -f2)"
			else
				start="${range}"
				stop="${range}"
			fi
			__dlang_filter_compilers "$start" "$stop"
		done
	else
		__dlang_filter_compilers "" ""
	fi
	[[ ${#__dlang_compiler_iuse[@]} -ne 0 ]] || die "No D compilers found that satisfy this package's contraints"

	IUSE="${__dlang_compiler_iuse[@]}"
	if [[ "${DLANG_PACKAGE_TYPE}" == "single" ]]; then
		REQUIRED_USE="^^ ( ${__dlang_compiler_iuse[@]} )"
	else
		REQUIRED_USE="|| ( ${__dlang_compiler_iuse[@]} )"
	fi
	DEPEND="${__dlang_depends[@]}"
	RDEPEND="${__dlang_depends[@]}"
}
__dlang_filter_versions

# We will need the real CHOST to find GDC and its library path.
__DLANG_CHOST="${CHOST}"

__dlang_phase_wrapper() {
	dlang_phase() {
		if declare -f d_src_${1} >/dev/null ; then
			d_src_${1}
		else
			default_src_${1}
		fi
	}

	if [[ "${DLANG_PACKAGE_TYPE}" == "single" ]]; then
		dlang_single_config dlang_phase "${1}"
	else
		dlang_foreach_config dlang_phase "${1}"
		# Handle any compiler & arch independent installation steps
		if declare -f d_src_${1}_all >/dev/null ; then
			d_src_${1}_all
		fi
	fi
}

__dlang_compiler_to_dlang_version() {
	local mapping
	case "$1" in
		"dmd") mapping="$2" ;;
		"gdc") mapping="${__dlang_gdc_frontend_mapping[${2}]}" ;;
		"ldc2") mapping="${__dlang_ldc2_frontend_mapping[${2}]}" ;;
		*) die "Compiler '${1}' is unknown." ;;
	esac
	echo ${mapping%% *}
}

__dlang_build_configurations() {
	local variants=() use_flag
	for use_flag in ${USE}; do
		case ${use_flag} in
			dmd-* | gdc-* | ldc-* | ldc2-*)
				if [[ "${DLANG_PACKAGE_TYPE}" == "single" ]]; then
					variants+=("default-${use_flag//_/.}")
				else
					for abi in $(multilib_get_enabled_abis); do
						variants+=("${abi}-${use_flag//_/.}")
					done
				fi
				;;
		esac
	done
	if [ ${#variants[@]} -eq 0 ]; then
		die "At least one compiler USE-flag must be selected. This should be checked by REQUIRED_USE in this package."
	fi
	echo "${variants[@]}"
}

# @FUNCTION: dlang_exec
# @DESCRIPTION:
# Run and print a shell command. Aborts the ebuild on error using "die".
dlang_exec() {
	echo "${@}"
	${@} || die
}

# @FUNCTION: dlang_compile_bin
# @DESCRIPTION:
# Compiles a D application. The first argument is the output file name, the
# other arguments are source files. Additional variables can be set to fine tune
# the compilation. They will be prepended with the proper flags for each
# compiler:
# versions - a list of versions to activate during compilation
# imports - a list of import paths
#
# Aditionally, if the ebuild offers the "debug" use flag, we will automatically
# raise the debug level to 1 during compilation.
dlang_compile_bin() {
	[[ "${DLANG_PACKAGE_TYPE}" == "single" ]] || die "Currently ${FUNCTION} only works with DLANG_PACKAGE_TYPE=\"single\"."

	local binname="${1}"
	local sources="${@:2}"

	dlang_exec ${DC} ${DCFLAGS} ${sources} $(__dlang_additional_flags) \
		${LDFLAGS} ${DLANG_OUTPUT_FLAG}${binname}
}

# @FUNCTION: dlang_compile_lib.so
# @DESCRIPTION:
# Compiles a D shared library. The first argument is the output file name, the
# second argument is the soname (typically file name without patch level
# suffix), the other arguments are source files. Additional variables and the
# "debug" use flag will be handled as described in dlang_compile_bin().
dlang_compile_lib.so() {
	local libname="${1}"
	local soname="${2}"
	local sources="${@:3}"

	dlang_exec ${DC} ${DCFLAGS} -m${MODEL} ${sources} $(__dlang_additional_flags) \
		${LDFLAGS} ${DLANG_SO_FLAGS} ${DLANG_LINKER_FLAG}-soname=${soname} \
		${DLANG_OUTPUT_FLAG}${libname}
}

fi
