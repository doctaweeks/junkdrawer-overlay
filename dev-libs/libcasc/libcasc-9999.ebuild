# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="An open-source implementation of library for reading CASC storage from Blizzard games since 2014"
HOMEPAGE="http://www.zezula.net/en/casc/main.html"
if [ $PV == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ladislav-zezula/CascLib.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="system-libtomcrypt"

DEPEND="app-arch/bzip2
		sys-libs/zlib
		system-libtomcrypt? ( dev-libs/libtomcrypt )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with system-libtomcrypt LIBTOMCRYPT)
	)

	cmake-utils_src_configure
}
