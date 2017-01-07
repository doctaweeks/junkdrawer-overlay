# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="The rendering HTTP API from Graphite-web, without the interface"
HOMEPAGE="https://github.com/brutasse/graphite-api"
SRC_URI="https://github.com/brutasse/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/cairocffi
	dev-python/flask
	>=dev-python/pyparsing-1.5.7
	dev-python/pytz
	dev-python/pyyaml
	dev-python/six
	dev-python/structlog
	dev-python/tzlocal"
