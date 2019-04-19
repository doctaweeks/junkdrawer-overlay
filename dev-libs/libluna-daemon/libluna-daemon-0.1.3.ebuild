# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="a dead simple library for daemonizing"
HOMEPAGE="https://github.com/doctaweeks/libluna-daemon"
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/doctaweeks/${PN}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/doctaweeks/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs"

RDEPEND="sys-libs/libcap-ng"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	if ! use static-libs ; then
		find "${ED}" -name "*.la" -delete || die
	fi
}
