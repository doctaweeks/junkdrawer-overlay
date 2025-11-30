# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..14} )
inherit distutils-r1 pypi

DESCRIPTION="Integration of psycopg2 with coroutine libraries"
HOMEPAGE="
	https://pypi.org/project/psycogreen/
	https://github.com/psycopg/psycogreen
"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
