# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="End to end Tensor IR/DSL stack for deploying deep learning workloads"
HOMEPAGE="https://github.com/dmlc/tvm"
EGIT_REPO_URI="https://github.com/dmlc/tvm"
EGIT_SUBMODULES=( '*' '-dmlc-core' '-HalideIR' )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="cuda llvm opencl"

DEPEND="sci-libs/dmlc-core
	dev-libs/halideir
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	llvm? ( sys-devel/llvm:= )
	opencl? ( virtual/opencl )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DUSE_CUDA=$(usex cuda)
		-DUSE_LLVM=$(usex llvm)
		-DUSE_OPENCL=$(usex opencl)
		-DINSTALL_DEV=ON
	)

	cmake-utils_src_configure
}
