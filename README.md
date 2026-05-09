# Palimpsest Dark Theme

A dark CRT-phosphor color palette for Kate/KTextEditor, qt6ct, Rofi, qBittorrent, and VS Code.

**Palette:** deep void backgrounds (`#080e09`, `#141e22`) with phosphor-green normal text (`#33ff33`), cyan chrome (`#19ffff`), neon accents (purple `#df78ff`, amber `#ffd866`, coral `#ff6e4a`), and deep-violet selection/highlight.

Designed for a writerly, terminal-aesthetic setup on a non-KDE Wayland desktop (Sway + qt6ct + Fusion style).

---

## Contents

| File | Installs to | Purpose |
|------|-------------|---------|
| `kate/palimpsest-dark.theme` | `~/.local/share/org.kde.syntax-highlighting/themes/` | Kate / KTextEditor syntax highlighting theme |
| `kde/PalimpsestDark.colors` | `~/.local/share/color-schemes/` | KDE Plasma color scheme (all QPalette roles) |
| `qt6ct/colors/palimpsest-dark.conf` | `~/.config/qt6ct/colors/` | Qt6 palette for qt6ct (non-Plasma desktops) |
| `qt6ct/qss/kate-writerly.qss` | `~/.config/qt6ct/qss/` | QSS chrome styling — phosphor glow on menubar, toolbar, statusbar, dock titles |
| `qt6ct/qss/scanlines.png` | `~/.config/qt6ct/qss/` | 4×8px scanline tile used by the QSS |
| `qt6ct/qss/scanlines.svg` | `~/.config/qt6ct/qss/` | Source SVG for the scanline tile |
| `gtk/gtk-3.0/gtk.css` | `~/.config/gtk-3.0/` | GTK3 chrome overlay — menubar + headerbar phosphor glow |
| `gtk/gtk-3.0/settings.ini` | `~/.config/gtk-3.0/` | GTK3 settings — Adwaita-dark base, Crimson Pro font |
| `gtk/gtk-4.0/gtk.css` | `~/.config/gtk-4.0/` | GTK4 chrome overlay — menubar + headerbar phosphor glow |
| `gtk/gtk-4.0/settings.ini` | `~/.config/gtk-4.0/` | GTK4 settings — Adwaita-dark base, Crimson Pro font |
| `kitty/palimpsest-dark.conf` | `~/.config/kitty/` | Kitty terminal colors, font, cursor (include from kitty.conf) |
| `sway/colors.conf` | `~/.config/sway/palimpsest-colors.conf` | Sway/SwayFX window border colors, font, shadows (include from sway config) |
| `waybar/style.css` | `~/.config/waybar/` | Waybar CSS — full Grimoire dark bar with phosphor glows and scanline overlay |
| `swaync/style.css` | `~/.config/swaync/` | SwayNC notification center CSS — full Grimoire dark theme |
| `swaylock/config` | `~/.config/swaylock/` | swaylock-effects config — Grimoire ring colors + indicator image |
| `nwg-drawer/drawer.css` | `~/.config/nwg-drawer/` | NWG Drawer app launcher CSS |
| `rofi/palimpsest.rasi` | `~/.config/rofi/themes/` | Rofi launcher theme |
| `qbittorrent/palimpsest.qbtheme` | `~/.config/qBittorrent/` | qBittorrent Qt client theme bundle |
| `qbittorrent/src/` | — | Source: color palette JSON, Qt QSS template, WebUI CSS template, build script (`gen.sh`) |
| `vscode/package.json` + `vscode/themes/palimpsest-dark.json` | `~/.vscode/extensions/palimpsest-dark/` | VS Code color theme extension |

---

## Install

```bash
bash install.sh
```

The install script copies all files to the correct locations and fixes the absolute `url()` path in the QSS (Qt requires absolute paths for `background-image`).

### Manual install

If you prefer to install manually, note that `qt6ct/qss/kate-writerly.qss` contains the placeholder `__QSS_DIR__` in its `url()` calls. Replace it with the absolute path to your qt6ct QSS directory before copying:

```bash
sed "s|__QSS_DIR__|${HOME}/.config/qt6ct/qss|g" \
    qt6ct/qss/kate-writerly.qss > ~/.config/qt6ct/qss/kate-writerly.qss
```

---

## Applying

### Kate syntax highlighting theme

In Kate: **Settings → Configure Kate → Fonts & Colors → Theme** → select *Palimpsest Dark*.

Or set it directly in `~/.config/katerc`:

```ini
[Kate Document Defaults]
Color Theme=Palimpsest Dark
```

### qt6ct palette + QSS

In `~/.config/qt6ct/qt6ct.conf`:

```ini
[Appearance]
color_scheme_path=/home/YOU/.config/qt6ct/colors/palimpsest-dark.conf
custom_palette=true
style=Fusion

[Fonts]
general=Alegreya SC,14,-1,5,50,0,0,0,0,0

[Interface]
stylesheets=/home/YOU/.config/qt6ct/qss/kate-writerly.qss
```

Replace `/home/YOU` with your actual home directory (or run `install.sh`, which handles this).

### Rofi

```bash
rofi -theme palimpsest [your usual rofi args]
```

Or set it as the default in `~/.config/rofi/config.rasi`:

```
@theme "palimpsest"
```

---

### qBittorrent

Copy `qbittorrent/palimpsest.qbtheme` to `~/.config/qBittorrent/` (or run `install.sh`).

In qBittorrent: **View → Interface → Use custom UI Theme** → select `palimpsest.qbtheme`.

To rebuild from source (requires `jq` and `rcc`):

```bash
cd qbittorrent/src
bash gen.sh --qt-only themes/palimpsest.json
```

The built bundle lands in `qt/palimpsest.qbtheme`.

---

### VS Code

Copy the `vscode/` directory to `~/.vscode/extensions/palimpsest-dark/` (or run `install.sh`).

Restart VS Code, then: **Preferences → Color Theme → Palimpsest Dark**.

---

## Related

- **[kate-retro-scanlines-plugin](https://github.com/glassdimly/kate-retro-scanlines-plugin)** — C++ KTextEditor plugin that renders a configurable scanline overlay directly in Kate's editor view, complementing this palette.

---

## License

[Poison Pill License](LICENSE) — free for individuals, nonprofits, open-source projects, and organizations under $10M revenue. Ethical conditions apply for large corporations.
