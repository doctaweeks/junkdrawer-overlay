# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )
GENTOO_DEPEND_ON_PERL=no

inherit cmake perl-module linux-info python-single-r1

DESCRIPTION="High-level language bindings for libnetfilter_log"
HOMEPAGE="https://github.com/chifflier/nflog-bindings"
MY_COMMIT="f3eda3551820e52d4c2fc82547b89d39c4a02125"
SRC_URI="https://github.com/chifflier/nflog-bindings/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

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
	net-libs/libnetfilter_log
	dev-lang/swig"

PATCHES=( "${FILESDIR}/${P}-Support-python-3-only.patch"
	"${FILESDIR}/${P}-Support-python-3-only-in-examples.patch" )

S="${WORKDIR}/${PN}-${MY_COMMIT}"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	# Check kernel configuration for NFLOG
	if linux_config_exists; then
		ebegin "Checking CONFIG_NETFILTER_NETLINK_LOG support"
		linux_chkconfig_present CONFIG_NETFILTER_NETLINK_LOG
		eend $? || \
			eerror 'Netfilter NFLOG over NFNETLINK interface support not found!'
		ebegin "Checking CONFIG_NETFILTER_XT_TARGET_NFLOG support"
		linux_chkconfig_present CONFIG_NETFILTER_XT_TARGET_NFLOG
		eend $? || \
			eerror '"NFLOG" target Support not found!'
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
	#emake DESTDIR="${D}" install PREFIX=/usr
	cmake_src_install
	use python && python_optimize
	docinto examples
	use examples && dodoc examples/*
}
