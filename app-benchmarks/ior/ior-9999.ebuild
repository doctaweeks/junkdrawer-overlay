# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

AT_M4DIR="config"
inherit autotools

DESCRIPTION="Parallel filesystem I/O benchmark"
HOMEPAGE="https://github.com/hpc/ior"
if [[ $PV == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hpc/ior.git"
else
	SRC_URI="https://github.com/hpc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
