# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Python CFFI bindings for libzfs"
HOMEPAGE="https://github.com/Xaroth/libzfs-python"
if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Xaroth/libzfs-python"
else
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="sys-fs/zfs
	dev-python/cffi[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
