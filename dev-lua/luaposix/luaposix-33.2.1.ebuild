# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

[[ "${PV}" = *9999* ]] && live=git-r3
inherit ${live}

DESCRIPTION="Lua bindings for POSIX APIs"
HOMEPAGE="https://github.com/luaposix/luaposix"
if [[ "${PV}" = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/luaposix/${PN}.git"
else
	SRC_URI="https://github.com/luaposix/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS=""
LICENSE="MIT"
SLOT="0"

IUSE="luajit ncurses test unicode"

DEPEND="!luajit? ( || ( dev-lang/lua:5.2 dev-lang/lua:5.1 >=dev-lang/lua-5.1:0 ) )
	luajit? ( dev-lang/luajit:2 )"
RDEPEND="${DEPEND}
	!luajit? ( || ( dev-lang/lua:5.2 dev-lua/LuaBitOp ) )"
DEPEND="${DEPEND}
	>=dev-lua/LDoc-1.4.2
	dev-lua/slingshot
	sys-apps/help2man
	dev-libs/gnulib
	dev-lang/perl"

DOCS=( "README.md" "NEWS.md" )

src_prepare() {
	rmdir gnulib || die
	ln -s "${EPREFIX}"/usr/share/gnulib . || die

	rmdir slingshot || die
	ln -s "${EPREFIX}"/usr/share/slingshot . || die

	# WARNING: Order matters! Slingshot options are processed first and are ignored otherwise!
	./bootstrap --skip-rock-checks --skip-git --skip-po --gnulib-srcdir=/usr/share/gnulib || die
}

src_configure() {
	local lua=lua
	use luajit && lua=luajit

	econf \
		LUA="${lua}" \
		$(use_with ncurses) \
		$(use_with unicode ncursesw)
}

src_compile() {
	emake -j1
}