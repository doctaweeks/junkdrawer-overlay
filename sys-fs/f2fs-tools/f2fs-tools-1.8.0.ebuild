# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/about/"
SRC_URI="https://danweeks.net/pub/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="~amd64 ~arm ~mips ~x86"
IUSE="selinux"

DEPEND="
	sys-apps/util-linux
	selinux? ( sys-libs/libselinux )"

src_configure() {
	#This is required to install to /sbin, bug #481110
	econf \
		--prefix=/ \
		--includedir=/usr/include \
		--disable-static \
		--with-selinux=$(usex selinux)
}

src_install() {
	default
	find "${D}" -name "*.la" -delete || die
}
