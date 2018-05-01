# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

MY_PV=${PV/_/-}

DESCRIPTION="Backend data caching and persistence daemon for Graphite"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="https://github.com/graphite-project/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~x64-solaris"

# whisper appears to have been missed from listing in install_requires in setup.py
RDEPEND="
	|| ( dev-python/twisted-core[${PYTHON_USEDEP}] >=dev-python/twisted-16.0.0[${PYTHON_USEDEP}] )
	dev-python/whisper[${PYTHON_USEDEP}]
	dev-python/txAMQP[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]"

PATCHES=(
	# Do not install the configuration and data files. We install them
	# somewhere sensible by hand. Patch for this vn. 0.9.14 has been extended
	# due to redhat's init scripts set to install unconditionally in setup.py
	"${FILESDIR}"/${PN}-1.1.3-no-data-files.patch
	)

S="${WORKDIR}/${PN}-${MY_PV}"

python_prepare_all() {
	# This sets prefix to /opt/graphite. We want FHS-style paths instead.
	export GRAPHITE_NO_PREFIX=1
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /etc/carbon
	doins conf/*

	dodir /var/log/carbon /var/lib/carbon/{whisper,lists,rrd}

	newinitd "${FILESDIR}"/carbon.initd2 carbon-cache
	newinitd "${FILESDIR}"/carbon.initd2 carbon-relay
	newinitd "${FILESDIR}"/carbon.initd2 carbon-aggregator

	newconfd "${FILESDIR}"/carbon.confd carbon-cache
	newconfd "${FILESDIR}"/carbon.confd carbon-relay
	newconfd "${FILESDIR}"/carbon.confd carbon-aggregator
}

pkg_postinst() {
	einfo 'This ebuild installs carbon into FHS-style paths.'
	einfo 'You will probably have to set GRAPHITE_CONF_DIR to /etc/carbon'
	einfo 'and GRAPHITE_STORAGE_DIR to /var/lib/carbon to make use of this'
	einfo '(see /etc/carbon/carbon.conf.example).'
	einfo ' '
	einfo 'OpenRC init script supports multiple instances !'
	einfo 'Example to run an instance b of carbon-cache :'
	einfo '    ln -s /etc/init.d/carbon-cache /etc/init.d/carbon-cache.b'
	einfo '    cp /etc/conf.d/carbon-cache /etc/conf.d/carbon-cache.b'
}
