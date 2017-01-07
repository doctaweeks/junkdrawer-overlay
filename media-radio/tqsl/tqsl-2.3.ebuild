# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils wxwidgets

DESCRIPTION="TrustedQSL log signing for the ARRL Logbook of the World (LoTW)"
HOMEPAGE="http://sourceforge.net/projects/trustedqsl/"
SRC_URI="http://www.arrl.org/files/file/LoTW%20Instructions/${P}.tar.gz"

LICENSE="tqsl"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tools"

DEPEND="sys-libs/zlib
		dev-libs/openssl:=
		sys-libs/db:=
		dev-libs/expat
		net-misc/curl
		x11-libs/wxGTK:="
RDEPEND="${DEPEND}"

DOCS=(AUTHORS.txt README LICENSE.txt)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build tools ALL_EXTRAPROGS)
	)

	cmake-utils_src_configure
}
