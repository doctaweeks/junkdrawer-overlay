# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="An MkDocs plugin that simplifies configuring page titles and their order"
HOMEPAGE="
	https://github.com/lukasgeiter/mkdocs-awesome-pages-plugin
	https://pypi.org/project/mkdocs-awesome-pages-plugin
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/wcmatch[${PYTHON_USEDEP}]
"
