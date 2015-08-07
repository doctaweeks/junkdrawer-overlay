# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION=3.2.0
inherit cmake-utils eutils

DESCRIPTION="Warp speed Data Transfer aims to transfer data between systems as fast as possible"
HOMEPAGE="https://www.facebook.com/WdtOpenSource"
if [[ $PV == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/facebook/wdt.git"
else
	KEYWORDS="~amd64"
	SRC_URI=""
fi

LICENSE="BSD"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-cpp/folly-0.52.0-r1
		dev-cpp/glog
		>=dev-cpp/gflags-2.1.2"
DEPEND="${RDEPEND}
		test? ( dev-cpp/gmock )"

src_prepare() {
	epatch "${FILESDIR}/wdt-9999-use-shared-folly.diff"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTING)
	)

	cmake-utils_src_configure
}
