# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WEBAPP_MANUAL_SLOT="yes"
inherit webapp

DESCRIPTION="Web frontend for sys-cluster/ganglia"
HOMEPAGE="http://ganglia.sourceforge.net"
SRC_URI="https://github.com/ganglia/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="vhosts"

DEPEND="net-misc/rsync"
RDEPEND="
	${DEPEND}
	${WEBAPP_DEPEND}
	>=sys-cluster/ganglia-3.3.7[-minimal]
	dev-lang/php[gd,xml,ctype]
	virtual/httpd-php
	media-fonts/dejavu"

PATCHES=( "${FILESDIR}/${P}-fix-mem-graph.patch" "${FILESDIR}/${P}-fix-mem-graph-2.patch" )

src_configure() {
	return 0
}

src_compile() {
	return 0
}

src_install() {
	webapp_src_preinst
	cd "${S}"
	emake \
		GDESTDIR="${MY_HTDOCSDIR}" \
		DESTDIR="${D}" \
		APACHE_USER=nobody \
		install || die
	webapp_configfile "${MY_HTDOCSDIR}"/conf_default.php
	webapp_src_install

	fowners -R nobody:nobody /var/lib/ganglia-web/dwoo
	fperms -R 777 /var/lib/ganglia-web/dwoo

	dodoc AUTHORS README TODO || die
}

pkg_postinst() {
	webapp_pkg_postinst

	# upgrade from < 3.5.6
	if [ -d "${ROOT}"/var/lib/ganglia/dwoo ]; then
		rm -rf "${ROOT}"/var/lib/ganglia/dwoo || die
	fi
}
