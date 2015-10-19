# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Lmod: An Environment Module System based on Lua, Reads TCL Modules, Supports a Software Hierarchy "
HOMEPAGE="http://www.tacc.utexas.edu/tacc-projects/lmod"
SRC_URI="https://github.com/TACC/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lua/luaposix
		dev-lua/luafilesystem"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog "You should add the following to your ~/.bashrc to use Lmod:"
	elog "[ -f /usr/lmod/lmod/init/bash ] && \\ "
	elog "	source /usr/lmod/lmod/init/bash"
}
