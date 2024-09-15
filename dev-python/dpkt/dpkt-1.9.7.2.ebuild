# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10,11,12,13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Fast, simple packet creation / parsing"
HOMEPAGE="https://github.com/kbandla/dpkt"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
