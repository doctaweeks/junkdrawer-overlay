# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10} )

inherit cmake perl-module linux-info python-single-r1

DESCRIPTION="High-level language bindings for libnetfilter_queue"
HOMEPAGE="https://github.com/chifflier/nfqueue-bindings"
MY_COMMIT=9bf0c343be1effa25f668d5e4efe92effa7e5d4e
SRC_URI="https://github.com/chifflier/nfqueue-bindings/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="perl python examples"
REQUIRED_USE="|| ( perl python ) python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	examples? (
		python? (
			$(python_gen_cond_dep '
				net-analyzer/scapy[${PYTHON_USEDEP}]
				dev-python/dpkt[${PYTHON_USEDEP}]
			')
			${PYTHON_DEPS}
		)
	)"
DEPEND="${RDEPEND}
	perl? ( dev-lang/perl )
	virtual/pkgconfig
	net-libs/libnetfilter_queue
	dev-lang/swig"

PATCHES=( "${FILESDIR}/${P}-Support-python-3-only.patch"
	"${FILESDIR}/${P}-Support-python-3-only-in-examples.patch" )

S="${WORKDIR}/${PN}-${MY_COMMIT}"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	# Check kernel configuration for NFQUEUE
	if linux_config_exists; then
		ebegin "Checking NETFILTER_NETLINK_QUEUE support"
		linux_chkconfig_present NETFILTER_NETLINK_QUEUE
		eend $? || \
			eerror 'Netfilter NFQUEUE over NFNETLINK interface support not found!'
		ebegin "Checking NETFILTER_XT_TARGET_NFQUEUE support"
		linux_chkconfig_present NETFILTER_XT_TARGET_NFQUEUE
		eend $? || \
			eerror '"NFQUEUE" target Support not found!'
	fi
}

src_prepare() {
	if use perl; then
		# Fix Perl destination directory
		perl_set_version
		sed -i "s|\${LIB_INSTALL_DIR}/perl\${PERL_VERSION}/|${VENDOR_ARCH}|" perl/CMakeLists.txt || die
	else
		sed -i 's|ADD_SUBDIRECTORY(perl)||' CMakeLists.txt || die
	fi

	if use python; then
		sed -i "s|\${LIB_INSTALL_DIR}/python\${PYTHON_VERSION}/dist-packages/|$(python_get_sitedir)|" python/CMakeLists.txt || die
	else
		sed -i 's|ADD_SUBDIRECTORY(python)||' CMakeLists.txt || die
	fi

	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
	use python && python_optimize
	docinto examples
	use examples && dodoc examples/*
}
