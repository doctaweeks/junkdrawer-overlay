# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_DATE="20160607"
MY_P="${P}-${MY_DATE}"

AUTOTOOLS_AUTORECONF=true
#AT_M4DIR="autoconf-archive/m4"

inherit autotools-multilib

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="https://github.com/json-c/json-c/wiki"
SRC_URI="https://github.com/json-c/json-c/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc static-libs"

RDEPEND="
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20140406-r3
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="doc? ( app-doc/doxygen )"

# tests break otherwise
AUTOTOOLS_IN_SOURCE_BUILD=1

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	sed -i -e "s:-Werror::" configure.ac || die
	autotools-multilib_src_prepare
}

src_test() {
	export USE_VALGRIND=0 VERBOSE=1
	autotools-multilib_src_test
}

src_compile() {
	autotools-multilib_src_compile
	use doc && doxygen Doxyfile
}

src_install() {
	use doc && HTML_DOCS=( "${S}"/doc/html )
	autotools-multilib_src_install

	# add symlink for projects not using pkgconfig
	dosym ../json-c /usr/include/json-c/json
}
