# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Python interface to Slurm"
HOMEPAGE="https://github.com/PySlurm/pyslrm"
if [ ${PV} == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PySlurm/${PN}"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=sys-cluster/slurm-16.05.0
	<=sys-cluster/slurm-16.05.3"
DEPEND="${DEPEND}
	dev-python/cython"
