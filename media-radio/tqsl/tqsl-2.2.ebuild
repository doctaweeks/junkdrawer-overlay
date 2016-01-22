# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils wxwidgets

DESCRIPTION="Libraries and utilities to use digital signatures for amateur radio QSL"
HOMEPAGE="http://sourceforge.net/projects/trustedqsl/"
SRC_URI="mirror://sourceforge/trustedqsl/TrustedQSL/v${PV}/${P}.tar.gz"

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

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build tools ALL_EXTRAPROGS)
	)

	cmake-utils_src_configure
}
