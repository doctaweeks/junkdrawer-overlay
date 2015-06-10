# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Navigation-mesh Toolset for Games"
HOMEPAGE="http://digestingduck.blogspot.com"

if [ $PV == 9999 ]; then
	EGIT_REPO_URI="https://github.com/memononen/recastnavigation.git"
else
	SRC_URI=""
fi

LICENSE="recastnavigation"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/$P-cmake.patch" )
