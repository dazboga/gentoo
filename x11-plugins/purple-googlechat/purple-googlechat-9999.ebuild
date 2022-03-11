# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="GoogleChat protocol for libpurple"
HOMEPAGE="https://github.com/EionRobb/purple-googlechat"
if [[ "${PV}" ==  9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EionRobb/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE=""

#PATCHES=(
#	"${FILESDIR}/${PN}-Makefile_fixes.patch"
#)

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	net-im/pidgin
	sys-libs/zlib:=
	dev-libs/protobuf-c
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	emake CC="$(tc-getCC)" PKG_CONFIG="$(tc-getBUILD_PKG_CONFIG)"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PKG_CONFIG="$(tc-getBUILD_PKG_CONFIG)" \
		install
}
