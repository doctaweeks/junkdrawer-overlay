# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Library providing high performance logging, tracing, ipc, and poll"
HOMEPAGE="https://github.com/asalkeld/libqb"
SRC_URI="https://github.com/ClusterLabs/${PN}/releases/download/v$MY_PV/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc examples static-libs test"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	test? ( dev-libs/check )
	doc? ( app-doc/doxygen[dot] )"

DOCS=(README.markdown ChangeLog)

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e '/dist_doc_DATA/d' -i Makefile.am || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && autotools-utils_src_compile doxygen
}

src_install() {
	use doc && HTML_DOCS=("${AUTOTOOLS_BUILD_DIR}/docs/html/")
	autotools-utils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi
}
