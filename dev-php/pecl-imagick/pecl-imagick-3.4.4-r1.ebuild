# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV="${PV/rc/RC}"

USE_PHP="php5-6 php7-1 php7-2 php7-3 php7-4"

inherit php-ext-pecl-r3

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library"
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples openmp test"

# imagemagick[-openmp] is advised wrt bug 547922 and upstream
# https://github.com/mkoppanen/imagick#openmp
RDEPEND=">=media-gfx/imagemagick-6.2.4:=[openmp=]"
DEPEND="${RDEPEND}
	test? ( >=media-gfx/imagemagick-6.2.4:=[jpeg,png,truetype] )"

PHP_EXT_ECONF_ARGS="--with-imagick=${EPREFIX}/usr"

pkg_setup() {
	if use openmp; then
		ewarn "OpenMP may cause stability issues in certain environments."
		ewarn "Try rebuild with USE=\"-openmp\" if you encounter runtime errors."
	fi
}
