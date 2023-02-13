# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Exports physical and virtual server performance metrics using the sFlow protocol"
HOMEPAGE="http://www.sflow.net"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sflow/host-sflow"
else
	SRC_URI="https://github.com/sflow/host-sflow/archive/v${PV}-1.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="APL-1.0"
SLOT="0"
IUSE="docker nflog openvswitch pcap"

DEPEND="nflog? ( net-libs/libnfnetlink )
	pcap? ( net-libs/libpcap )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/host-sflow-${PV}-1"

src_compile() {
	local features=()
	use docker && features+=( 'DOCKER' )
	use nflog && features+=( 'NFLOG' )
	use openvswitch && features+=( 'OVS' )
	use pcap && features+=( 'PCAP' )
	local emakeopts=( FEATURES="${features[@]}" )
	emake "${emakeopts[@]}"
}

src_install() {
	emake install INSTROOT="${D}" MODDIR="/usr/lib64/${PN}" FEATURES=""
}
