# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.1.6-r1.ebuild,v 1.1 2013/11/23 13:42:18 ssuominen Exp $

EAPI=5

inherit autotools eutils udev user toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://git.code.sf.net/p/libmtp/code"
	EGIT_PROJECT="libmtp"
	inherit git-2
else
	KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+crypt doc examples static-libs"

RDEPEND="virtual/libusb:1
	crypt? ( dev-libs/libgcrypt )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog README TODO"

pkg_setup() {
	enewgroup plugdev
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fbsdlibusb.patch
	if [[ ${PV} == *9999* ]]; then
		touch config.rpath # This is from upstream autogen.sh
		eautoreconf
	fi
	epatch ${FILESDIR}/dev.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable doc doxygen) \
		$(use_enable crypt mtpz) \
		--with-udev="$(get_udevdir)" \
		--with-udev-group=plugdev \
		--with-udev-mode=0660
}

src_install() {
	default
	prune_libtool_files

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi

	sed -i -e '/^Unable to open/d' "${ED}/$(get_udevdir)"/rules.d/*-libmtp.rules || die #481666
}
