# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

PYTHON_COMPAT=( python{3_4,3_5} )
inherit eutils python-any-r1

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
SRC_URI="https://github.com/cliffordwolf/${PN}/archive/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	sys-libs/readline:=
	virtual/libffi
	dev-vcs/git
	dev-lang/tcl:=
	dev-vcs/mercurial"

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7-prefix.patch

	eapply_user
}

src_configure() {
	emake config-gcc
}