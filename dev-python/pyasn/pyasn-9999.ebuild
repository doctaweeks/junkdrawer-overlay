# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 git-r3

DESCRIPTION="Python IP address to Autonomous System Number lookup module"
HOMEPAGE="https://github.com/hadiasghari/pyasn"
EGIT_REPO_URI="https://github.com/hadiasghari/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

IUSE=""
