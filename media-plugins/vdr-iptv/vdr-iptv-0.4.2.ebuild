# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-iptv/vdr-iptv-0.3.0.ebuild,v 1.1 2009/06/04 13:08:26 zzam Exp $

EAPI="2"

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Add a logical device capable of receiving IPTV"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.7.7"

RDEPEND="${DEPEND}"

src_prepare() {
	fix_vdr_libsi_include sidscanner.c
	vdr-plugin_src_prepare
}
