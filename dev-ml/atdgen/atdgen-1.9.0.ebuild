# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit findlib

DESCRIPTION="Generates OCaml JSON (de)serializers and validators from ATD type definitions"
HOMEPAGE="https://mjambon.github.io/atdgen-doc"
SRC_URI="https://github.com/mjambon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
DEPEND="dev-lang/ocaml:=[ocamlopt?]
		>=dev-ml/atd-1.1.0
		>=dev-ml/biniou-1.0.6
		>=dev-ml/yojson-1.2.1"
RDEPEND="${DEPEND}"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

src_compile() {
	emake all -j1
	if use ocamlopt; then
		emake opt
	fi
}

src_install () {
	findlib_src_preinst
	mkdir -p "${ED}"/usr/bin
	emake PREFIX="${ED}"/usr install
}
