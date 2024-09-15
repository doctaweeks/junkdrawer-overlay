# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12,13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="An MkDocs plugin that simplifies configuring page titles and their order"
HOMEPAGE="
	https://github.com/lukasgeiter/mkdocs-awesome-pages-plugin
	https://pypi.org/project/mkdocs-awesome-pages-plugin
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/wcmatch[${PYTHON_USEDEP}]
"
