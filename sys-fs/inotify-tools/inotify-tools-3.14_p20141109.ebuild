# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="a set of command-line programs providing a simple interface to inotify"
HOMEPAGE="https://github.com/rvoicilas/inotify-tools/wiki"
EGIT_REPO_URI="https://github.com/rvoicilas/inotify-tools"
EGIT_COMMIT="1df9af4d6cd0f4af4b1b19254bcf056aed4ae395"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# only docs installed are doxygen ones, so use /html
	econf \
		--docdir=/usr/share/doc/${PF}/html \
		$(use_enable doc doxygen)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS ChangeLog
}
