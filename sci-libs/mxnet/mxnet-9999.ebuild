# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} )
DISTUTILS_OPTIONAL=1
inherit cmake-utils distutils-r1 git-r3

DESCRIPTION="Flexible and Efficient Library for Deep Learning"
HOMEPAGE="http://mxnet.io/"
EGIT_REPO_URI="https://github.com/dmlc/mxnet"
EGIT_SUBMODULES=( "*" "-dmlc-core" "-nnvm" "-ps-lite" )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="cuda distributed opencv openmp python"

RDEPEND="sci-libs/dmlc-core
	sci-libs/nnvm
	sci-libs/atlas
	distributed? ( sci-libs/ps-lite )
	opencv? ( media-libs/opencv )
	python? ( ${PYTHON_DEPS} dev-python/numpy[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

PATCHES=( "${FILESDIR}/${P}-build-fix.patch" "${FILESDIR}/${P}-fix-python-stupid.patch" )

src_prepare() {
	default
	if use python; then
		cd python
		distutils-r1_src_prepare
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DUSE_CUDA=$(usex cuda)
		-DUSE_OPENCV=$(usex opencv)
		-DUSE_OPENMP=$(usex openmp)
		-DBLAS=Atlas
		-DUSE_DIST_KVSTORE=$(usex distributed)
	)

	addwrite /dev/nvidia-uvm
	addwrite /dev/nvidiactl
	addwrite /dev/nvidia0

	cmake-utils_src_configure

	if use python; then
		cd python;
		distutils-r1_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use python; then
		cd python
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}"
		distutils-r1_src_compile
	fi
}

src_install() {
	doheader -r include/mxnet

	if use python; then
		cd python
		distutils-r1_src_install
	fi

	cd "${BUILD_DIR}"
	dolib.so libmxnet.so
}
