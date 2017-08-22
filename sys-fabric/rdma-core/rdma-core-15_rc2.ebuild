# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

MY_PV=${PV/_rc/-rc}
MY_P=${PN}-${MY_PV}

DESCRIPTION="RDMA core userspace libraries and daemons"
HOMEPAGE="https://github.com/linux-rdma/rdma-core"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linux-rdma/rdma-core"
else
	SRC_URI="https://github.com/linux-rdma/${PN}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
IUSE=""

DEPEND="!sys-fabric/libibverbs"
RDEPEND="${DEPEND}
	sys-apps/ethtool"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-15_rc2-fix-SYSCONFDIR-use.patch" )
