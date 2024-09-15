# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="an MPI-coordinated metadata benchmark"
HOMEPAGE="https://sourceforge.net/projects/mdtest"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}%20latest/${P}/${P}.tgz"

S=${WORKDIR}

LICENSE="mdtest"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

src_compile() {
	emake MPI_CC=mpicc
}

src_install() {
	dobin mdtest
	doman mdtest.1
}
