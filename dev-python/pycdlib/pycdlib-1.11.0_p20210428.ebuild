# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )
inherit distutils-r1

MY_COMMIT="6f0f7b67835eeb26ed3b045035f9b182d3fa08b0"

DESCRIPTION="Python library to read and write ISOs"
HOMEPAGE="https://clalancette.github.io/pycdlib/"
SRC_URI="https://github.com/clalancette/pycdlib/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${MY_COMMIT}"
