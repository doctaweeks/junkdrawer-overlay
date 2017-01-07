# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

[[ "${PV}" = *9999* ]] && live=git-r3
inherit toolchain-funcs ${live}

DESCRIPTION="LuaDoc-compatible documentation generation system"
HOMEPAGE="http://stevedonovan.github.io/ldoc"
if [[ "${PV}" = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/stevedonovan/${PN}.git"
	KEYWORDS="-*"
else
	SRC_URI="https://github.com/stevedonovan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="luajit"

DEPEND="!luajit? ( || ( dev-lang/lua:5.1 >=dev-lang/lua-5.1:0 ) )
	luajit? ( dev-lang/luajit:2 )"
RDEPEND="${DEPEND}
	dev-lua/penlight"

DOCS=( "readme.md" "changes.md" )

src_install() {
	local lua=lua pkg_config="$(tc-getPKG_CONFIG)" lua_prefix lua_bindir lua_sharedir
	use luajit && lua=luajit

	lua_prefix="$(${pkg_config} --variable prefix ${lua})"
	lua_bindir="$(${pkg_config} --variable INSTALL_BIN ${lua})"
	lua_sharedir="$(${pkg_config} --variable INSTALL_LMOD ${lua})"

	[[ "${lua_bindir}" ]] || lua_bindir="${lua_prefix}/bin"

	for dir in "${lua_bindir}" "${lua_sharedir}" ; do
		mkdir -p "${D}/${dir}" || die
	done

	emake install \
		DESTDIR="${D}" \
		LUA="${lua}" \
		LUA_PREFIX="${lua_prefix}" \
		LUA_BINDIR="${lua_bindir}" \
		LUA_SHAREDIR="${lua_sharedir}"
}
