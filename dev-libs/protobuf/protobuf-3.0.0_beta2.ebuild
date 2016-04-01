# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
JAVA_PKG_IUSE="source"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
DISTUTILS_OPTIONAL=1
MY_PV="3.0.0-beta-1"

inherit autotools-multilib eutils flag-o-matic distutils-r1 java-pkg-opt-2

DESCRIPTION="Google's Protocol Buffers -- an efficient method of encoding structured data"
HOMEPAGE="http://code.google.com/p/protobuf/"
SRC_URI="https://github.com/google/protobuf/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/10" # subslot = soname major version
KEYWORDS="~amd64"
IUSE="java python static-libs vim-syntax"

CDEPEND="
	python? ( ${PYTHON_DEPS} )"
DEPEND="${CDEPEND}
	java? ( >=virtual/jdk-1.5 )
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"
RDEPEND="${CDEPEND}
	java? ( >=virtual/jre-1.5 )"

S="${WORKDIR}/protobuf-${MY_PV}"

src_prepare() {
	append-cxxflags -DGOOGLE_PROTOBUF_NO_RTTI
	autotools-multilib_src_prepare

	if use python; then
		cd python && distutils-r1_src_prepare
	fi
}

multilib_src_compile() {
	default

	if multilib_is_native_abi; then
		if use python; then
			einfo "Compiling Python library ..."
			pushd "${S}"/python >/dev/null
			PROTOC="${BUILD_DIR}"/src/protoc distutils-r1_src_compile
			popd >/dev/null
		fi

		if use java; then
			einfo "Compiling Java library ..."
			pushd "${S}" >/dev/null
			"${BUILD_DIR}"/src/protoc --java_out=java/src/main/java --proto_path=src src/google/protobuf/descriptor.proto
			mkdir java/build
			pushd java/src/main/java >/dev/null
			ejavac -d ../../../build $(find . -name '*.java') || die "java compilation failed"
			popd >/dev/null
			jar cf ${PN}.jar -C java/build . || die "jar failed"
			popd >/dev/null
		fi
	fi
}

src_compile() {
	autotools-multilib_src_compile
}

src_test() {
	autotools-multilib_src_test check

	if use python; then
		pushd python >/dev/null
		distutils-r1_src_test
		popd >/dev/null
	fi
}

src_install() {
	autotools-multilib_src_install

	if use python; then
		pushd python >/dev/null
		distutils-r1_src_install
		popd >/dev/null
	fi

	if use java; then
		java-pkg_dojar ${PN}.jar
		use source && java-pkg_dosrc java/src/main/java/*
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins editors/proto.vim
		insinto /usr/share/vim/vimfiles/ftdetect/
		doins "${FILESDIR}"/proto.vim
	fi
}
