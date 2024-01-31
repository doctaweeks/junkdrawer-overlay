# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High performance command line tool for stream encryption"
HOMEPAGE="https://github.com/vstakhov/hpenc"
if [ "${PV}" == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vstakhov/hpenc"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/openssl
	dev-libs/libsodium"
RDEPEND="${DEPEND}"
BDEPEND=""
