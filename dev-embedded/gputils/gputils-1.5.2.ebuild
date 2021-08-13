# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic toolchain-funcs

# archive generated from svn trunk

DESCRIPTION="Tools including assembler, linker and librarian for PIC microcontrollers"
HOMEPAGE="https://gputils.sourceforge.io"
SRC_URI="https://danweeks.net/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

# need lyx to generate docs
DEPEND="doc? ( app-office/lyx )"

PATCHES=( "${FILESDIR}/${PN}-1.5.0-no-clang.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	tc-ld-disable-gold #369291
	append-cflags -std=gnu11
	default
}

src_compile() {
	default
}

src_install() {
	default
	use doc && dodoc doc/gputils.pdf
}
