# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/crossover-office-pro-bin/crossover-office-pro-bin-9.1.0.ebuild,v 1.2 2010/08/03 18:25:00 vapier Exp $

EAPI="3"

inherit eutils

DESCRIPTION="simplified/streamlined version of wine with commercial support"
HOMEPAGE="http://www.codeweavers.com/products/cxoffice/"
SRC_URI="install-crossover-${PV}.bin"

LICENSE="CROSSOVER"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="nas"
RESTRICT="fetch strip"

RDEPEND="sys-libs/glibc
	x11-libs/libXrandr
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	dev-util/desktop-file-utils
	nas? ( media-libs/nas )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"
#	media-libs/jpeg:62
#	media-libs/libpng:1.2"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	einfo "and place ${A} in ${DISTDIR}"
}

src_unpack() {
	#unpack_makeself
	echo "tail -c +745959 ${DISTDIR}/$A > ${P}.zip"
	tail -c +745959 "${DISTDIR}/$A" > ${P}.zip || die "tail"
	unpack ./${P}.zip
	rm -f ${P}.zip || die
}

src_install() {
	dodir /opt/cxoffice
	cp -r * "${D}"/opt/cxoffice || die "cp failed"
#	rm -r "${D}"/opt/cxoffice/setup.{sh,data}
	insinto /opt/cxoffice/etc
	doins share/crossover/data/cxoffice.conf
}

pkg_postinst() {
	elog "Run /opt/cxoffice/bin/cxsetup as normal user to create"
	elog "bottles and install Windows applications."
}
