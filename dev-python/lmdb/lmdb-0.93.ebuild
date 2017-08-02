# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

MY_PN=lmdb
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python binding for the LMDB 'Lightning' Database"
HOMEPAGE="https://pypi.python.org/pypi/lmdb https://github.com/dw/py-lmdb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="OPENLDAP"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/lmdb"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

python_compile() {
	LMDB_FORCE_SYSTEM=1 distutils-r1_python_compile
}
