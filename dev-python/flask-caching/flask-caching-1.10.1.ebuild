# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10,11} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="Continuation of the Flask-Cache extension"
HOMEPAGE="https://github.com/sh4nks/flask-caching"
SRC_URI="https://github.com/sh4nks/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.12[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
