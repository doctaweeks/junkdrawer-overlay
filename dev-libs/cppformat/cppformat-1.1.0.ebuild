# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Small, safe and fast formatting library for C++"
HOMEPAGE="http://fmtlib.net"
if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cppformat/cppformat.git"
else
	SRC_URI="https://github.com/cppformat/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="doc test"

DEPEND="doc? ( dev-python/sphinx app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-shared.patch"
	epatch "${FILESDIR}/${PN}-configure.patch"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build doc DOC)
		$(cmake-utils_use_build test TESTS)
	)

	cmake-utils_src_configure
}
