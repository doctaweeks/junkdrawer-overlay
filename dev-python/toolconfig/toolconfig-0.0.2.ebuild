# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1

DESCRIPTION="multi-profile configs for dev tools"
HOMEPAGE="https://github.com/doctaweeks/toolconfig"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
