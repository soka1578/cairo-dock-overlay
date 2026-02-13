# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake


DESCRIPTION="Cairo-dock is a fast, responsive, Mac OS X-like dock."
HOMEPAGE="http://www.glx-dock.org"
SRC_URI="https://github.com/Cairo-Dock/cairo-dock-core/archive/refs/tags/3.6.2.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="crypt xcomposite desktop_manager wayland"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2:2
	gnome-base/librsvg:2
	net-misc/curl
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libXrender
	x11-libs/gtk+:3
	crypt? ( sys-libs/glibc )
	xcomposite? (
		x11-libs/libXcomposite
		x11-libs/libXinerama
		x11-libs/libXtst
	)
	wayland? (
		gui-libs/gtk-layer-shell
		app-misc/wayland-utils
	)
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

src_configure() {
	mycmakeargs=(
		`use desktop_manager && echo "-Denable-desktop-manager=ON" || echo "-Denable-desktop-manager=OFF"`
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "Additional plugins are available to extend the functionality"
	elog "of Cairo-Dock. It is recommended to install at least"
	elog "x11-pluings/cairo-dock-plugins."
}
