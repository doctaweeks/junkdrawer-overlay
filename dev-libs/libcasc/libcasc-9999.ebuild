# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for reading CASC storage from Blizzard games since 2014"
HOMEPAGE="http://www.zezula.net/en/casc/main.html"
if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ladislav-zezula/CascLib.git"
else
	SRC_URI="https://github.com/ladislav-zezula/CascLib/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="app-arch/bzip2
		sys-libs/zlib"
RDEPEND="${DEPEND}"
