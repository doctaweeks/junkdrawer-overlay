# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9,10,11,12} )
DISTUTILS_USE_SETUPTOOLS=bdepend
inherit distutils-r1 pypi

DESCRIPTION="Pure python implementation of the ar archive format"
HOMEPAGE="https://github.com/vidstige/ar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
