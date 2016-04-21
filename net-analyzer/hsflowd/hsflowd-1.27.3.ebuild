# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Exports physical and virtual server performance metrics using the sFlow protocol"
HOMEPAGE="http://www.sflow.net"
SRC_URI="mirror://sourceforge/host-sflow/Latest/${P}.tar.gz"

LICENSE="APL-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake ULOG=no
}

src_install() {
	emake install INSTROOT="${D}"
}
