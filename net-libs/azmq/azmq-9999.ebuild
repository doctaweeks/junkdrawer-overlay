# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="C++ language binding library integrating ZeroMQ with Boost Asio"
HOMEPAGE="https://github.com/zeromq/azmq"
if [ ${PV} -eq 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zeromq/azmq.git"
	KEYWORDS=""
else
	SRC_URI=""
fi

LICENSE="Boost-1.0"
SLOT="0"
IUSE=""

DEPEND=">=net-libs/zeromq-4.0.0
		>=dev-libs/boost-1.54"
RDEPEND="${DEPEND}"
