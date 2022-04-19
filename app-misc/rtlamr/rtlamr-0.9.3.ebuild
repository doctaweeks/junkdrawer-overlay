# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN=github.com/bemasher/rtlamr
inherit go-module

DESCRIPTION="software defined radio receiver for utility smart meters"
HOMEPAGE="https://github.com/bemasher/rtlamr"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${P}-deps.tar.xz"

LICENSE="AGPL-3 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build \
		-mod=readonly \
		-ldflags "${go_ldflags}" \
		-work -o "bin/${PN}" ./ || die
}

src_install() {
	dobin bin/${PN}
	dodoc *.md *.csv
}
