# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

MY_PV=${PV/_/-}

DESCRIPTION="Fixed size round-robin style database"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="https://github.com/graphite-project/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~x64-solaris"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"
