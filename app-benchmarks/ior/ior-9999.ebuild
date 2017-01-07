# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1
AT_M4DIR="config"
inherit autotools-utils

DESCRIPTION="Parallel filesystem I/O benchmark"
HOMEPAGE="https://github.com/LLNL/ior"
if [[ $PV == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LLNL/ior.git"
else
	SRC_URI="https://github.com/LLNL/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"
