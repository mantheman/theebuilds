# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Suds is a lightweight SOAP python client for consuming Web Services."
HOMEPAGE="https://fedorahosted.org/suds/"
SRC_URI="https://fedorahosted.org/releases/s/u/suds/python-${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/python-${P}/"
