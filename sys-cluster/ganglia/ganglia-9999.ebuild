# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic systemd toolchain-funcs

DESCRIPTION="A scalable distributed monitoring system for clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ganglia/monitor-core"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ganglia/monitor-core/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~x86"
	S="${WORKDIR}/monitor-core-${PV}"
fi

LICENSE="BSD"

SLOT="0"
IUSE="minimal pcre python examples"

RDEPEND="dev-libs/confuse:=
	dev-libs/expat
	>=dev-libs/apr-1.0
	net-libs/libnsl:0=
	!dev-db/firebird
	net-libs/libtirpc:=
	pcre? ( dev-libs/libpcre )
	python? ( dev-lang/python:2.7 )
	!minimal? ( net-analyzer/rrdtool )"

DEPEND="
	${RDEPEND}
	>=net-libs/rpcsvc-proto-1"

BDEPEND="virtual/pkgconfig"

src_prepare() {
	eautoreconf

	default
}

src_configure() {
	append-flags $("$(tc-getPKG_CONFIG)" --cflags libtirpc)
	append-libs $("$(tc-getPKG_CONFIG)" --libs libtirpc)

	econf \
		--with-systemdsystemunitdir=$(systemd_get_systemunitdir) \
		--enable-gexec \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--enable-static=no \
		--with-python="${EPREFIX}"/usr/bin/python2 \
		$(use_enable python) \
		$(use_with pcre libpcre) \
		$(use_with !minimal gmetad)
}

src_install() {
	local exdir=/usr/share/doc/${P}

	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/gmond.rc-2 gmond
	doman {mans/*.1,gmond/*.5}
	dodoc AUTHORS INSTALL NEWS

	dodir /etc/ganglia/conf.d
	use python && dodir /usr/$(get_libdir)/ganglia/python_modules
	gmond/gmond -t > "${ED}"/etc/ganglia/gmond.conf

	if use examples; then
		insinto ${exdir}/cmod-examples
		doins gmond/modules/example/*.c
		if use python; then
			# Installing as an examples per upstream.
			insinto ${exdir}/pymod-examples
			doins gmond/python_modules/*/*.py
			insinto ${exdir}/pymod-examples/conf.d
			doins gmond/python_modules/conf.d/*.pyconf
		fi
	fi

	if ! use minimal; then
		insinto /etc/ganglia
		doins gmetad/gmetad.conf
		doman mans/gmetad.1

		newinitd "${FILESDIR}"/gmetad.rc-2 gmetad
		keepdir /var/lib/ganglia/rrds
		fowners nobody:nobody /var/lib/ganglia/rrds
	fi
}

pkg_postinst() {
	elog "A default configuration file for gmond has been generated"
	elog "for you as a template by running:"
	elog "    /usr/sbin/gmond -t > /etc/ganglia/gmond.conf"

	elog "The web frontend for Ganglia has been split off.  Emerge"
	elog "sys-cluster/ganglia-web if you need it."
}
