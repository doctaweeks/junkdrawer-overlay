# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="A typeface specially designed for user interfaces"
HOMEPAGE="https://rsms.me/inter/"
SRC_URI="https://github.com/rsms/inter/releases/download/v2.5/Inter-UI-2.5.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPENDS="app-arch/unzip"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}"

src_prepare() {
	default
	mv "${S}/Inter UI (TTF)"/*.${FONT_SUFFIX} "${FONT_S}" || die
}
