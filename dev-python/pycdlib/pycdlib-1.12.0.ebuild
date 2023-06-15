# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9,10,11,12} )
inherit distutils-r1 pypi

DESCRIPTION="Python library to read and write ISOs"
HOMEPAGE="https://clalancette.github.io/pycdlib/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
