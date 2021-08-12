# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps toolchain-funcs

DESCRIPTION="tool to turn traditional container/OS images into unprivileged sandboxes"
HOMEPAGE="https://github.com/NVIDIA/enroot"
SRC_URI="https://danweeks.net/distfiles/${P}.tar.xz"

LICENSE="Apache-2.0 GPL-2 MIT || ( BSD ISC )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/zstd
	app-misc/jq
	sys-fs/squashfs-tools
	sys-process/parallel"
BDEPEND="sys-devel/libtool"

PATCHES=( "${FILESDIR}/${P}-fix-install.patch"
	"${FILESDIR}/${P}-fake-ppc64le-support.patch" )

FILECAPS=(
	cap_sys_admin+pe usr/bin/enroot-mksquashovlfs --
	cap_sys_admin,cap_mknod+pe usr/bin/enroot-aufs2ovlfs
)

pkg_pretend() {
		if [[ ${MERGE_TYPE} != binary ]]; then
			has ccache ${FEATURES} && die "FEATURES=ccache doesn't work with ${PN}"
		fi
}

src_compile() {
	emake ARCH=$(tc-arch-kernel) prefix=/usr sysconfdir=/etc
}

src_install() {
	emake DESTDIR="${D}" install prefix=/usr sysconfdir=/etc
	einstalldocs
}
