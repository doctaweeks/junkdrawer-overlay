# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library to read Squashfs image files"
HOMEPAGE="
	https://pypi.org/project/PySquashfsImage/
"

EGIT_REPO_URI="https://github.com/matteomattei/PySquashfsImage"

LICENSE="LGPL-2.1"
SLOT="0"
