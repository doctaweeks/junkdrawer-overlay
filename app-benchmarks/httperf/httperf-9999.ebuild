# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="A tool from HP for measuring web server performance"
HOMEPAGE="http://code.google.com/p/httperf/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/httperf/${PN}.git"
else
	SRC_URI="http://httperf.googlecode.com/files/${P}.tar.gz"
	KEYWORDS="amd64 ~mips x86 ~amd64-linux ~x64-macos"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README.md TODO )
