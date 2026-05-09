#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KATE_THEME_DIR="${HOME}/.local/share/org.kde.syntax-highlighting/themes"
KDE_COLORS_DIR="${HOME}/.local/share/color-schemes"
QT6CT_COLORS_DIR="${HOME}/.config/qt6ct/colors"
QT6CT_QSS_DIR="${HOME}/.config/qt6ct/qss"
GTK3_DIR="${HOME}/.config/gtk-3.0"
GTK4_DIR="${HOME}/.config/gtk-4.0"
KITTY_DIR="${HOME}/.config/kitty"
SWAY_DIR="${HOME}/.config/sway"
WAYBAR_DIR="${HOME}/.config/waybar"
SWAYNC_DIR="${HOME}/.config/swaync"
SWAYLOCK_DIR="${HOME}/.config/swaylock"
NWG_DRAWER_DIR="${HOME}/.config/nwg-drawer"
ROFI_DIR="${HOME}/.config/rofi/themes"
QBITTORRENT_DIR="${HOME}/.config/qBittorrent"
VSCODE_EXT_DIR="${HOME}/.vscode/extensions/palimpsest-dark"

echo "Installing Palimpsest Dark theme files..."
echo ""

# ── Kate / KTextEditor syntax highlighting theme ──────────────────────────────
mkdir -p "${KATE_THEME_DIR}"
cp "${REPO_DIR}/kate/palimpsest-dark.theme" "${KATE_THEME_DIR}/"
echo "  ✓ kate → ${KATE_THEME_DIR}/"

# ── KDE color scheme ──────────────────────────────────────────────────────────
mkdir -p "${KDE_COLORS_DIR}"
cp "${REPO_DIR}/kde/PalimpsestDark.colors" "${KDE_COLORS_DIR}/"
echo "  ✓ kde  → ${KDE_COLORS_DIR}/"

# ── qt6ct palette + QSS ──────────────────────────────────────────────────────
mkdir -p "${QT6CT_COLORS_DIR}" "${QT6CT_QSS_DIR}"
cp "${REPO_DIR}/qt6ct/colors/palimpsest-dark.conf" "${QT6CT_COLORS_DIR}/"
cp "${REPO_DIR}/qt6ct/qss/scanlines.png" "${QT6CT_QSS_DIR}/"
cp "${REPO_DIR}/qt6ct/qss/scanlines.svg" "${QT6CT_QSS_DIR}/"
# Fix __QSS_DIR__ placeholder — Qt url() requires an absolute path
sed "s|__QSS_DIR__|${QT6CT_QSS_DIR}|g" \
    "${REPO_DIR}/qt6ct/qss/kate-writerly.qss" \
    > "${QT6CT_QSS_DIR}/kate-writerly.qss"
echo "  ✓ qt6ct → ${QT6CT_COLORS_DIR}/ + ${QT6CT_QSS_DIR}/ (path substituted)"

# ── GTK 3 ─────────────────────────────────────────────────────────────────────
mkdir -p "${GTK3_DIR}"
cp "${REPO_DIR}/gtk/gtk-3.0/gtk.css"      "${GTK3_DIR}/"
cp "${REPO_DIR}/gtk/gtk-3.0/settings.ini" "${GTK3_DIR}/"
echo "  ✓ gtk-3.0 → ${GTK3_DIR}/"

# ── GTK 4 ─────────────────────────────────────────────────────────────────────
mkdir -p "${GTK4_DIR}"
cp "${REPO_DIR}/gtk/gtk-4.0/gtk.css"      "${GTK4_DIR}/"
cp "${REPO_DIR}/gtk/gtk-4.0/settings.ini" "${GTK4_DIR}/"
echo "  ✓ gtk-4.0 → ${GTK4_DIR}/"

# ── Kitty terminal ────────────────────────────────────────────────────────────
mkdir -p "${KITTY_DIR}"
cp "${REPO_DIR}/kitty/palimpsest-dark.conf" "${KITTY_DIR}/"
echo "  ✓ kitty → ${KITTY_DIR}/"
echo "    Add to kitty.conf: include ~/.config/kitty/palimpsest-dark.conf"

# ── Sway / SwayFX colors ──────────────────────────────────────────────────────
mkdir -p "${SWAY_DIR}"
cp "${REPO_DIR}/sway/colors.conf" "${SWAY_DIR}/palimpsest-colors.conf"
echo "  ✓ sway → ${SWAY_DIR}/palimpsest-colors.conf"
echo "    Add to sway config: include ~/.config/sway/palimpsest-colors.conf"

# ── Waybar ────────────────────────────────────────────────────────────────────
mkdir -p "${WAYBAR_DIR}"
cp "${REPO_DIR}/waybar/style.css" "${WAYBAR_DIR}/"
echo "  ✓ waybar → ${WAYBAR_DIR}/"

# ── SwayNC (sway notification center) ────────────────────────────────────────
mkdir -p "${SWAYNC_DIR}"
cp "${REPO_DIR}/swaync/style.css" "${SWAYNC_DIR}/"
echo "  ✓ swaync → ${SWAYNC_DIR}/"

# ── Swaylock ──────────────────────────────────────────────────────────────────
mkdir -p "${SWAYLOCK_DIR}"
sed "s|__CONFIG_DIR__|${SWAYLOCK_DIR}|g" \
    "${REPO_DIR}/swaylock/config" \
    > "${SWAYLOCK_DIR}/config"
echo "  ✓ swaylock → ${SWAYLOCK_DIR}/config (path substituted)"
echo "    Note: copy your bg-globe.png to ${SWAYLOCK_DIR}/bg-globe.png"

# ── NWG Drawer ───────────────────────────────────────────────────────────────
mkdir -p "${NWG_DRAWER_DIR}"
cp "${REPO_DIR}/nwg-drawer/drawer.css" "${NWG_DRAWER_DIR}/"
echo "  ✓ nwg-drawer → ${NWG_DRAWER_DIR}/"

# ── Rofi ──────────────────────────────────────────────────────────────────────
mkdir -p "${ROFI_DIR}"
cp "${REPO_DIR}/rofi/palimpsest.rasi" "${ROFI_DIR}/"
echo "  ✓ rofi → ${ROFI_DIR}/"

# ── qBittorrent ───────────────────────────────────────────────────────────────
mkdir -p "${QBITTORRENT_DIR}"
cp "${REPO_DIR}/qbittorrent/palimpsest.qbtheme" "${QBITTORRENT_DIR}/"
echo "  ✓ qbittorrent → ${QBITTORRENT_DIR}/palimpsest.qbtheme"
echo "    In qBittorrent: View → Interface → Use custom UI Theme → select that file"

# ── VS Code ───────────────────────────────────────────────────────────────────
mkdir -p "${VSCODE_EXT_DIR}/themes"
cp "${REPO_DIR}/vscode/package.json" "${VSCODE_EXT_DIR}/"
cp "${REPO_DIR}/vscode/themes/palimpsest-dark.json" "${VSCODE_EXT_DIR}/themes/"
echo "  ✓ vscode → ${VSCODE_EXT_DIR}/"
echo "    Restart VS Code, then select theme: Palimpsest Dark"

# ── gsettings (GNOME / GTK font + color-scheme) ──────────────────────────────
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface color-scheme    prefer-dark    2>/dev/null || true
    gsettings set org.gnome.desktop.interface font-name       'Crimson Pro 16'  2>/dev/null || true
    gsettings set org.gnome.desktop.interface document-font-name 'Crimson Pro 16' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface monospace-font-name 'Space Mono 11' 2>/dev/null || true
    echo "  ✓ gsettings — dark mode + Crimson Pro / Space Mono fonts"
fi

echo ""
echo "Done. Manual steps:"
echo "  Qt  : open qt6ct → Appearance: Style=Fusion, Color scheme=palimpsest-dark,"
echo "        Fonts=Alegreya SC 14pt, Stylesheets=kate-writerly.qss"
echo "  Kate: Settings → Fonts & Colors → Theme → Palimpsest Dark"
echo "  Kitty: add 'include ~/.config/kitty/palimpsest-dark.conf' to kitty.conf"
echo "  Sway: add 'include ~/.config/sway/palimpsest-colors.conf' to sway config"
echo "  Rofi: add '@theme \"palimpsest\"' to ~/.config/rofi/config.rasi"
echo "  KDE : System Settings → Colors → Palimpsest Dark"
echo "  Swaylock: copy bg-globe.png to ~/.config/swaylock/ (not included — personal asset)"
echo "  qBittorrent: View → Interface → Use custom UI Theme → ~/.config/qBittorrent/palimpsest.qbtheme"
echo "  VS Code: restart, then Preferences → Color Theme → Palimpsest Dark"
