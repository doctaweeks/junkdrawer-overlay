# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10,11} )
inherit distutils-r1

DESCRIPTION="Integration of psycopg2 with coroutine libraries"
HOMEPAGE="
	https://pypi.org/project/psycogreen/
	https://github.com/psycopg/psycogreen
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# tests disabled until eventlet supports py3.10
#BDEPEND="
#	test? (
#		dev-python/eventlet[${PYTHON_USEDEP}]
#		dev-python/gevent[${PYTHON_USEDEP}]
#		dev-python/psycopg[${PYTHON_USEDEP}]
#		dev-python/pytest[${PYTHON_USEDEP}]
#		dev-python/six[${PYTHON_USEDEP}]
#	)
#"

#distutils_enable_tests pytest
