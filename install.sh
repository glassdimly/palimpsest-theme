#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KATE_THEME_DIR="${HOME}/.local/share/org.kde.syntax-highlighting/themes"
QT6CT_COLORS_DIR="${HOME}/.config/qt6ct/colors"
QT6CT_QSS_DIR="${HOME}/.config/qt6ct/qss"
ROFI_THEME_DIR="${HOME}/.config/rofi/themes"

echo "Installing Palimpsest Dark theme files..."

# Kate / KTextEditor syntax highlighting theme
mkdir -p "${KATE_THEME_DIR}"
cp "${REPO_DIR}/kate/palimpsest-dark.theme" "${KATE_THEME_DIR}/"
echo "  ✓ kate/palimpsest-dark.theme → ${KATE_THEME_DIR}/"

# qt6ct color palette
mkdir -p "${QT6CT_COLORS_DIR}"
cp "${REPO_DIR}/qt6ct/colors/palimpsest-dark.conf" "${QT6CT_COLORS_DIR}/"
echo "  ✓ qt6ct/colors/palimpsest-dark.conf → ${QT6CT_COLORS_DIR}/"

# QSS + scanline assets
mkdir -p "${QT6CT_QSS_DIR}"
cp "${REPO_DIR}/qt6ct/qss/scanlines.png" "${QT6CT_QSS_DIR}/"
cp "${REPO_DIR}/qt6ct/qss/scanlines.svg" "${QT6CT_QSS_DIR}/"
echo "  ✓ qt6ct/qss/scanlines.{png,svg} → ${QT6CT_QSS_DIR}/"

# Fix __QSS_DIR__ placeholder with the real absolute path
sed "s|__QSS_DIR__|${QT6CT_QSS_DIR}|g" \
    "${REPO_DIR}/qt6ct/qss/kate-writerly.qss" \
    > "${QT6CT_QSS_DIR}/kate-writerly.qss"
echo "  ✓ qt6ct/qss/kate-writerly.qss → ${QT6CT_QSS_DIR}/ (path substituted)"

# Rofi theme
mkdir -p "${ROFI_THEME_DIR}"
cp "${REPO_DIR}/rofi/palimpsest.rasi" "${ROFI_THEME_DIR}/"
echo "  ✓ rofi/palimpsest.rasi → ${ROFI_THEME_DIR}/"

echo ""
echo "Done. Next steps:"
echo "  1. In qt6ct: set Color scheme → palimpsest-dark, Style → Fusion,"
echo "     Fonts → Alegreya SC 14pt, Stylesheets → kate-writerly.qss"
echo "  2. In Kate: Settings → Fonts & Colors → Theme → Palimpsest Dark"
echo "  3. For Rofi: add '@theme \"palimpsest\"' to ~/.config/rofi/config.rasi"
echo "  4. For the scanline overlay in Kate's editor, see:"
echo "     https://github.com/glassdimly/kate-retro-scanlines-plugin"
