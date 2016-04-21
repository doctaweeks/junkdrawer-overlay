# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Hawk Access Auth plugin for pyramid"
HOMEPAGE="https://github.com/mozilla-services/pyramid_hawkauth"
SRC_URI="https://github.com/mozilla-services/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/pyramid-1.3[${PYTHON_USEDEP}]
	>=dev-python/hawkauthlib-0.1[${PYTHON_USEDEP}]
	>=dev-python/tokenlib-0.3[${PYTHON_USEDEP}]
	dev-python/webtest"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"