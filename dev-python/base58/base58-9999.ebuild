# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Base58 and Base58Check compatible with the bitcoin network"
HOMEPAGE="https://github.com/keis/base58"

if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keis/base58"
else
	SRC_URI="https://github.com/keis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
