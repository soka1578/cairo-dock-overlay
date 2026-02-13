# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id $

EAPI="8"

inherit cmake flag-o-matic

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="http://www.glx-dock.org"
SRC_URI="https://rig0.tuxhome.com.ar/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="alsa disks exif +gmenu gnome +gtk3 indicator3 kde mail +terminal gnote vala webkit xfce xgamma xklavier zeitgeist"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/librsvg:2
	sys-apps/dbus
	x11-libs/cairo
	!gtk3? ( x11-libs/gtk+:2 )
	x11-libs/gtkglext
	~x11-misc/cairo-dock-${PV}
	gtk3? ( x11-libs/gtk+:3 )
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	kde? ( kde-frameworks/kdelibs )
	terminal? ( x11-libs/vte:= )
	vala? ( dev-lang/vala:= )
	webkit? ( >=net-libs/webkit-gtk-1.4.0:3 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	gnote? ( app-misc/gnote )
	indicator3? ( dev-libs/libindicator:= )
	zeitgeist? ( dev-libs/libzeitgeist )
	mail? ( net-libs/libetpan )
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/libdbusmenu[gtk3]
"

PATCHES=( "${FILESDIR}"/${P}-gcc10-extern.patch
		"${FILESDIR}"/${PF}-weather.patch)

src_configure() {
	append-flags "-D_POSIX_C_SOURCE=200809L"
	mycmakeargs=(
		# broken with 0.99.x (as of cairo-dock 3.3.2)
		"-Denable-upower-support=OFF"
		`use gtk3 && echo "-Dforce-gtk2=OFF" || echo "-Dforce-gtk2=ON"`
		-Denable-global-menu=ON
		-Denable-alsa-mixer=$(usex alsa)
		-Denable-sound-effects=$(usex alsa)
		-Denable-disks=$(usex disks)
		-Denable-exif-support=$(usex exif)
		-Denable-gmenu=$(usex gmenu)
		-Denable-gnome-integration=$(usex gnome)
		-Dwith-indicator3=$(usex indicator3)
		-Denable-kde-integration=$(usex kde)
		-Denable-mail=$(usex mail)
		-Denable-terminal=$(usex terminal)
		-Denable-vala-interface=$(usex vala)
		-Denable-weblets=$(usex webkit)
		-Denable-xfce-integration=$(usex xfce)
		-Denable-xgamma=$(usex xgamma)
		-Denable-keyboard-indicator=$(usex xklavier)
		-Denable-recent-events=$(usex zeitgeist)
	)
	cmake_src_configure
}
