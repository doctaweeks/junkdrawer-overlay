# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils eutils git-r3 readme.gentoo user

DESCRIPTION="A software motion detector"
HOMEPAGE="http://www.lavrsen.dk/twiki/bin/view/Motion/WebHome"
EGIT_MIN_CLONE_TYPE="mirror"
EGIT_REPO_URI="https://github.com/Mr-Dave/motion"
EGIT_COMMIT="9b4c16cae0ea77950cc156a9c82947ac51825f68"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE="ffmpeg libav mysql postgres +v4l"

RDEPEND="
	sys-libs/zlib
	virtual/jpeg
	ffmpeg? (
		libav? ( media-video/libav:= )
		!libav? ( media-video/ffmpeg:0= )
	)
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
"
DEPEND="${RDEPEND}
	v4l? ( virtual/os-headers )
"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="You need to setup /etc/motion/motion.conf before running
motion for the first time.
You can install motion detection as a service, use:
rc-update add motion default
"

pkg_setup() {
	enewuser motion -1 -1 -1 video
}

src_configure() {
	local myeconfargs=(
		$(use_with v4l)
		$(use_with ffmpeg)
		$(use_with mysql)
		$(use_with postgres pgsql)
		--without-optimizecpu
	)
	autotools-utils_src_configure
}

src_install() {
	HTML_DOCS=("${BUILD_DIR}/motion_guide.html")
	DOCS=(CHANGELOG CODE_STANDARD CREDITS FAQ README)

	autotools-utils_src_install

	into /usr/share/doc/${PF}/examples
	dobin "${BUILD_DIR}"/thread*.conf

	newinitd "${FILESDIR}"/motion.initd-r2 motion
	newconfd "${FILESDIR}"/motion.confd motion

	readme.gentoo_create_doc
}
