# AGENTS.md — Kate Retro Scanlines Plugin

Context for AI agents (and humans) working on this repo.
Covers the non-obvious gotchas discovered while building and installing a KTextEditor plugin on a non-KDE desktop.

---

## Qt / Theme Setup

- **Kate ignores `QT_QPA_PLATFORMTHEME` from your shell.** It daemonizes and bypasses your login env. Fix: wrapper script at `~/.local/bin/kate` (must be earlier in `$PATH` than `/usr/sbin/kate`):
  ```bash
  exec env QT_QPA_PLATFORMTHEME=qt6ct QT_PLUGIN_PATH="${HOME}/.local/lib/qt6/plugins" /usr/sbin/kate "$@"
  ```
- **Breeze style is not installed on a non-Plasma setup.** Use `style=Fusion` in `~/.config/qt6ct/qt6ct.conf` — it ships with Qt and is always available.
- **Verify the env actually reached Kate:**
  ```bash
  strings /proc/$(pgrep -f /usr/sbin/kate)/environ | grep QT_QPA
  ```

---

## Plugin Enable / Disable

- **`katerc` does NOT control which plugins load.** Kate's plugin manager reads `[Kate Plugins]` from the *session* config, not the global config.
- **Session file for the default session:** `~/.local/share/kate/anonymous.katesession`
- **Plugin key uses the `lib` prefix** — derived from `QFileInfo(metaData.fileName()).baseName()`:
  ```ini
  [Kate Plugins]
  libkatescanlineplugin=true   # NOT katescanlineplugin=true
  ```
- **Always `SIGKILL` before editing the session file.** SIGTERM triggers a session save that overwrites your changes:
  ```bash
  pkill -KILL kate
  ```

---

## Build & Install

- Default install prefix is `~/.local` (set in `CMakeLists.txt`). Override with `-DCMAKE_INSTALL_PREFIX=...`.
- Plugin lands at `${prefix}/lib/qt6/plugins/kf6/ktexteditor/libkatescanlineplugin.so`.
- Always configure a fresh build dir pointing at the repo source — don't reuse a stale build dir that references an old source path:
  ```bash
  cmake -S /path/to/kate-retro-scanlines-plugin -B /tmp/build -DCMAKE_INSTALL_PREFIX=~/.local
  cmake --build /tmp/build
  cmake --install /tmp/build
  ```

---

## Debugging

- **Kate daemonizes — stderr goes to `/dev/null`.** `qDebug()` is silent. Log to a file instead:
  ```cpp
  int fd = open("/tmp/kate-plugin.log", O_WRONLY|O_CREAT|O_APPEND, 0644);
  write(fd, msg, strlen(msg)); write(fd, "\n", 1); close(fd);
  ```

---

## Writing a KTextEditor Plugin

- **QSS cannot paint scanlines** (or any pixel-level effect). Only a C++ `QWidget` overlay works.
- **`view->editorWidget()`** returns `KateViewInternal` (the actual text surface), not the `KTextEditor::View` container (which includes gutters, scrollbars, etc.).
- **Full-window coverage:** parent the overlay to `mainWindow->window()`; use a `ChildAdded` event filter + `raise()` to stay on top.
- **Circular dependency in one `.cpp`:** `ScanlinePlugin` ↔ `ScanlinePluginView` — any inline method body that touches the other class will fail with `invalid use of incomplete type`. Move those bodies out-of-line, after both classes are fully defined.
- **`KColorButton`** is in `KF6WidgetsAddons`, not `KF6TextEditor`. Requires `find_package(KF6WidgetsAddons)` and `KF6::WidgetsAddons` in your link libs.

---

## Config Persistence

- **`KSharedConfig::openConfig()`** writes to `~/.config/katerc` — correct for plugin preferences.
- The **session file** (`anonymous.katesession`) controls plugin load state only. These are separate files with separate purposes — don't conflate them.
