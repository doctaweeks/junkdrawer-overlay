# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DLANG_VERSION_RANGE="2.066-2.067"
DLANG_PACKAGE_TYPE="single"

inherit autotools dlang

DESCRIPTION="An open-source lint program for C++ developed by, and used at Facebook"
HOMEPAGE="https://github.com/facebookarchive/flint"
if [ ${PV} == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/facebookarchive/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="Boost-1.0"
SLOT="0"
IUSE=""

DEPEND="dev-cpp/folly"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/flint-9999-Fix-build-after-C-removal.patch"

	eautoreconf
}
