# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

PYTHON_COMPAT=( python{3_4,3_5} )
inherit eutils git-r3 python-any-r1 toolchain-funcs

DESCRIPTION="IceStorm - tools for analyzing and creating bitstreams for Lattice iCE40 FPGAs"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
EGIT_REPO_URI="https://github.com/cliffordwolf/icestorm.git"

SLOT="0"
KEYWORDS=""
IUSE="ftdi"

RDEPEND="ftdi? ( dev-embedded/libftdi:= )"
DEPEND="
		${PYTHON_DEPS}
		virtual/pkgconfig
		${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-path-fix.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
	if ! use ftdi; then
		epatch "${FILESDIR}"/${P}-no-iceprog.patch
	fi

	eapply_user
}

src_compile() {
	export PREFIX=/usr
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="$CFLAGS"
}
