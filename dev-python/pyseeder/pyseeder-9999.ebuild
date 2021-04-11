# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 git-r3

DESCRIPTION="reseed data managment tools for I2P"
HOMEPAGE="https://github.com/PurpleI2P/pyseeder"
EGIT_REPO_URI="https://github.com/PurpleI2P/pyseeder"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
