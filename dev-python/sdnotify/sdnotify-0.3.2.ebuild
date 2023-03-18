# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit pypi distutils-r1

DESCRIPTION="A pure Python implementation of systemd's service notification protocol"
HOMEPAGE="https://pypi.python.org/pypi/sdnotify https://github.com/bb4242/sdnotify"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
