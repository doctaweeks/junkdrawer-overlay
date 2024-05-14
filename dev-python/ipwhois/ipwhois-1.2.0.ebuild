# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

DESCRIPTION="Python module for retrieving and parsing whois data for IPv4 and IPv6 addresses"
HOMEPAGE="https://github.com/secynic/ipwhois"
SRC_URI="https://github.com/secynic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="test" # network-heavy test which provably fail in restricted environments

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
