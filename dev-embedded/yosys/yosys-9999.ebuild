# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
inherit eutils git-r3 python-any-r1

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
EGIT_REPO_URI="https://github.com/cliffordwolf/yosys.git"

SLOT="0"
KEYWORDS=""
IUSE="+abc"

RDEPEND="
	sys-libs/readline:=
	dev-libs/libffi:=
	dev-vcs/git
	dev-lang/tcl:="

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

src_configure() {
	emake config-gcc
	echo "ENABLE_ABC := $(usex abc 1 0)" >> "${S}/Makefile.conf"
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" STRIP=true install
}
