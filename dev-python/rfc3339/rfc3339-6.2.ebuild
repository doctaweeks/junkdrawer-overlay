# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1 pypi

DESCRIPTION="Format dates according to the RFC 3339"
HOMEPAGE="https://pypi.org/project/rfc3339"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
