# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/inputlircd/inputlircd-0.0.1_pre15.ebuild,v 1.1 2009/11/16 14:26:05 zzam Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Inputlirc daemon to utilize /dev/input/event*"
HOMEPAGE="http://svn.sliepen.eu.org/inputlirc/trunk"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/enable_repeat.patch
	sed -e 's:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' -i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "emake install failed"

	newinitd "${FILESDIR}"/inputlircd.init.2  inputlircd
	newconfd "${FILESDIR}"/inputlircd.conf  inputlircd
}
