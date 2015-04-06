# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="An open-source lint program for C++ developed by, and used at Facebook"
HOMEPAGE="https://github.com/facebook/flint"
if [ ${PV} == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/facebook/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="Boost-1.0"
SLOT="0"
IUSE=""

DEPEND="dev-cpp/folly
		dev-lang/dmd"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/flint-9999-Fix-build-after-C-removal.patch"

	eautoreconf
}
