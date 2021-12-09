# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="A one-stop shop for process isolation"
HOMEPAGE="https://github.com/aristanetworks/bst"

EGIT_REPO_URI="https://github.com/aristanetworks/bst"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

IUSE="man"
RESTRICT="test"

BDEPEND="sys-libs/libcap
	man? ( app-text/scdoc )"

PATCHES=( "${FILESDIR}/${PN}-Do-not-force-compressed-manpages.patch" )

src_prepare() {
	default
	sed -i "/install_dir/d" meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
	)
	meson_src_configure
}
