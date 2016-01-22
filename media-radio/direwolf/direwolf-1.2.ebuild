# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="software \"soundcard\" modem/TNC and APRS encoder/decoder"
HOMEPAGE="https://github.com/wb2osz/direwolf"
SRC_URI="https://github.com/wb2osz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-misc/makedepend"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-cflags.patch"
	epatch "${FILESDIR}/${P}-destdir.patch"
}

src_compile() {
	tc-export AR CC
	emake CFLAGS="${CFLAGS}"
}
