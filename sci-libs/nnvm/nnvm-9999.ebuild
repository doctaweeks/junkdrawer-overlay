# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Intermediate Computational Graph Representation for Deep Learning Systems"
HOMEPAGE="https://github.com/dmlc/nnvm"
EGIT_REPO_URI="https://github.com/dmlc/nnvm"
EGIT_SUBMODULES=()

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

# TODO: fusion/cuda submodule plugin
DEPEND="sci-libs/dmlc-core"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake-utils_src_configure
}

src_install() {
	doheader -r include/nnvm

	cd "${BUILD_DIR}"
	dolib.so libnnvm.so
}
