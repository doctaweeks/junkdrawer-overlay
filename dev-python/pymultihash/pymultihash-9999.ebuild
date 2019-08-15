# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Python implementation of the multihash specification"
HOMEPAGE="https://github.com/ivilata/pymultihash"

if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ivilata/pymultihash"
else
	EGIT_COMMIT=""
	SRC_URI="https://github.com/ivilata/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/pymultihash-9999-exclude-tests.patch" )

pkg_postinst() {
	elog "pymultihash can optionally support additional hashes:"
	elog " * sha3   dev-python/pysha3"
	elog " * blake2 dev-python/pyblake2"
	elog "You probably also want base58 support (dev-python/base58)"
}
