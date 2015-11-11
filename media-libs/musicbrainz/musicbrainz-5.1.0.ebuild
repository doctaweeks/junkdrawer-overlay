# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="The MusicBrainz Client Library (for accessing the latest XML based web service)"
HOMEPAGE="http://musicbrainz.org/doc/libmusicbrainz"
SRC_URI="https://github.com/metabrainz/lib${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="5"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND="dev-libs/libxml2
		net-libs/neon"
DEPEND="${RDEPEND}
	test? ( dev-util/cppunit )"

S=${WORKDIR}/lib${PN}-release-${PV}

DOCS="AUTHORS.txt NEWS.txt README.md"

src_install() {
	cmake-utils_src_install

	if use examples; then
		docinto examples
		dodoc examples/*.{c,cc,txt}
	fi
}
