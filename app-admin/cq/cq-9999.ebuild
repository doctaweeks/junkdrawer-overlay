# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools-utils git-r3

DESCRIPTION="A command queue"
HOMEPAGE="https://github.com/RPI-HPC/cq"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/RPI-HPC/${PN}"
	AUTOTOOLS_AUTORECONF=1
else
	SRC_URI=""
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/protobuf-c
		net-libs/zeromq
		>=sys-auth/munge-0.5.11"
RDEPEND="${DEPEND}"
