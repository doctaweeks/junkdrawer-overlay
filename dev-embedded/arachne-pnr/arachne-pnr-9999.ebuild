# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils git-r3

DESCRIPTION="Arachne PNR - free and open-source place and route tool for FPGAs"
HOMEPAGE="https://github.com/cseed/arachne-pnr"
LICENSE="ISC"
EGIT_REPO_URI="https://github.com/cseed/arachne-pnr.git"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-embedded/icestorm"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-path-fix.patch
	eapply_user
}
