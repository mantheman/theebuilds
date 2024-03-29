# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic libtool

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	utils?	( mirror://sourceforge/freetype/ft2demos-${PV}.tar.bz2 )
	doc?	( mirror://sourceforge/freetype/${PN}-doc-${PV}.tar.bz2 )"

LICENSE="FTL GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="X auto-hinter bindist debug doc utils fontforge +cleartype lcdfilter"

DEPEND="sys-libs/zlib
	X?	( x11-libs/libX11
		  x11-libs/libXau
		  x11-libs/libXdmcp )"

RDEPEND="${DEPEND}"

src_prepare() {
	enable_option() {
		sed -i -e "/#define $1/a #define $1" \
			include/freetype/config/ftoption.h \
			|| die "unable to enable option $1"
	}

	disable_option() {
		sed -i -e "/#define $1/ { s:^:/*:; s:$:*/: }" \
			include/freetype/config/ftoption.h \
			|| die "unable to disable option $1"
	}

	if ! use bindist; then
		# See http://freetype.org/patents.html
		# ClearType is covered by several Microsoft patents in the US
		enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING
	fi

	if use auto-hinter; then
		disable_option TT_CONFIG_OPTION_BYTECODE_INTERPRETER
		enable_option TT_CONFIG_OPTION_UNPATENTED_HINTING
	fi

	if use debug; then
		enable_option FT_DEBUG_LEVEL_TRACE
		enable_option FT_DEBUG_MEMORY
	fi

	disable_option FT_CONFIG_OPTION_OLD_INTERNALS

	if use lcdfilter; then
		epatch "${FILESDIR}"/${P}-subpixel-hinting.patch
		epatch "${FILESDIR}"/${P}-additionnal.patch
		epatch "${FILESDIR}"/${P}-protect-style-name.patch
		epatch "${FILESDIR}"/${P}-tricky-fonts.patch

		enable_option TT_CONFIG_OPTION_SUBPIXEL_HINTING
		enable_option TT_CONFIG_OPTION_SUBPIXEL_HINTING_ADDITIONAL_TWEAKS
	fi

	epatch "${FILESDIR}"/${PN}-2.3.2-enable-valid.patch

	if use utils; then
		cd "${WORKDIR}/ft2demos-${PV}"
		sed -i -e "s:\.\.\/freetype2$:../freetype-${PV}:" Makefile
		# Disable tests needing X11 when USE="-X". (bug #177597)
		if ! use X; then
			sed -i -e "/EXES\ +=\ ftdiff/ s:^:#:" Makefile
		fi
	fi

	elibtoolize
	epunt_cxx
}

src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake
	econf
}

src_compile() {
	emake || die "emake failed"

	if use utils; then
		cd "${WORKDIR}/ft2demos-${PV}"
		emake || die "ft2demos emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PROBLEMS,TODO}

	use doc && dohtml -r docs/*

	if use utils; then
		rm "${WORKDIR}"/ft2demos-${PV}/bin/README
		for ft2demo in ../ft2demos-${PV}/bin/*; do
			./builds/unix/libtool --mode=install $(type -P install) -m 755 "$ft2demo" \
				"${D}"/usr/bin
		done
	fi

	if use fontforge; then
		# Probably fontforge needs less but this way makes things simplier...
		einfo "Installing internal headers required for fontforge"
		find src/truetype include/freetype/internal -name '*.h' | \
		while read header; do
			mkdir -p "${D}/usr/include/freetype2/internal4fontforge/$(dirname ${header})"
			cp ${header} "${D}/usr/include/freetype2/internal4fontforge/$(dirname ${header})"
		done
	fi

	if use lcdfilter; then
		doenvd "${FILESDIR}"/99lcdfilter
	fi
}

pkg_postinst() {
	elog "The TrueType bytecode interpreter is no longer patented and thus no"
	elog "longer controlled by the bindist USE flag.  Enable the auto-hinter"
	elog "USE flag if you want the old USE="bindist" hinting behavior."
	echo
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "See http://forums.gentoo.org/viewtopic-t-511382.html for support topic on Gentoo forums."
	echo
}
