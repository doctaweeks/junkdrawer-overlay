# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit findlib

DESCRIPTION="Syntax for cross-language type definitions"
HOMEPAGE="https://mjambon.github.io/atdgen-doc"
SRC_URI="https://github.com/mjambon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0/${PV}"
LICENSE="BSD"
KEYWORDS="~amd64"

IUSE="examples +ocamlopt"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
		dev-ml/easy-format
		dev-ml/menhir"
DEPEND="${RDEPEND}"

src_compile() {
	emake all -j1
	use ocamlopt && emake opt
}

src_install() {
	findlib_src_preinst
	mkdir -p "${ED}"/usr/bin
	emake PREFIX="${ED}"/usr install
	dodoc README.md
}
