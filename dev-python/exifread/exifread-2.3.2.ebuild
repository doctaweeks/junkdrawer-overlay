# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

MY_PN="exif-py"

DESCRIPTION="Easy to use Python module to extract Exif metadata from tiff and jpeg files"
HOMEPAGE="https://github.com/ianare/exif-py"
SRC_URI="https://github.com/ianare/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"
