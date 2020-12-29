# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..3} )

inherit lua-single

DESCRIPTION="A Lua-based environment module system supporting TCL and software hierarchy"
HOMEPAGE="http://www.tacc.utexas.edu/tacc-projects/lmod"
SRC_URI="https://github.com/TACC/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="$(lua_gen_cond_dep 'dev-lua/luaposix[${LUA_USEDEP}]')
	$(lua_gen_cond_dep 'dev-lua/lua-term[${LUA_USEDEP}]')
	$(lua_gen_cond_dep '>=dev-lua/luafilesystem-1.6.2[${LUA_USEDEP}]')
	dev-lang/tcl:=
	${LUA_DEPS}"
RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
		--with-lua-include="${EPREFIX}/$(lua_get_include_dir)"
	)

	econf "${myeconfargs[@]}"
}

pkg_postinst() {
	elog "You should add the following to your ~/.bashrc to use Lmod:"
	elog "[ -f /usr/lmod/lmod/init/bash ] && \\ "
	elog "	source /usr/lmod/lmod/init/bash"
}
