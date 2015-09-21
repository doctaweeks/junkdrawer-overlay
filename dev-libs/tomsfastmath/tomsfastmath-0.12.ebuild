# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils toolchain-funcs multilib

DESCRIPTION="portable fixed precision math library geared towards doing one thing very fast"
HOMEPAGE="http://libtom.net/"
SRC_URI="http://libtom.net/files/tfm-${PV}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e "s:gcc:$(tc-getCC):g" \
		-e "s:--mode=link gcc:--mode=link $(tc-getCC) --tag=CC $(tc-getCC):g" \
		makefile.shared || die
	sed -i \
		-e '/install.*HEADERS/s:$: -m644:' \
		-e "1iLIBPATH=/usr/$(get_libdir)" \
		makefile* || die
}

src_compile() {
	emake -f makefile.shared IGNORE_SPEED=1 || die
}

src_install() {
	emake -f makefile.shared DESTDIR="${D}" install || die
	dodoc changes.txt doc/*.pdf || die
	docinto demo ; dodoc demo/*.c || die
}
