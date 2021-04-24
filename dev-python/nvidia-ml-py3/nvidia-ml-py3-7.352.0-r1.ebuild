# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1

DESCRIPTION="Python 3 Bindings for the NVIDIA Management Library"
HOMEPAGE="https://github.com/nicolargo/nvidia-ml-py3 https://pypi.org/project/nvidia-ml-py3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"
