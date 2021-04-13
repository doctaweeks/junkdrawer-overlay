# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Python Rate-Limiter using Leaky-Bucket Algorimth Family"
HOMEPAGE="https://github.com/vutran1710/PyrateLimiter"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	sed -i -e '/entry_points/d' setup.py || die

	default
}

pkg_postinst() {
	elog "Install dev-python/redis-py for Redis support (RedisBucket)"
}
