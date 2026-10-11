# Lumora Desktop — Rust + Tauri 2 (Windows & Linux)

A production desktop application built with **Rust + Tauri 2**. It wraps a web
frontend in a native window and ships as a **signed Windows installer (NSIS)** and
**Linux packages (AppImage + .deb)**, with a built-in self‑updater.

> This repository showcases the **Rust / Tauri desktop layer** (the web frontend is
> a separate project).

---

## Highlights (what the Rust layer does)

- **Tauri 2 + Rust core** — a native `#[tauri::command]` (`src/main.rs`) that checks a
  remote manifest and, if a newer version exists, **downloads and installs the update**
  in the background via `tauri-plugin-updater`.
- **Professional NSIS installer** — custom install/uninstall hooks
  (`installer-hooks.nsh`), branded header/sidebar artwork, LZMA compression, and a
  **bundled WebView2 bootstrapper** so it installs cleanly on a fresh Windows machine.
- **Cross-platform from one config** — Windows `nsis` + Linux `appimage` + `deb`
  (`tauri.conf.json`).
- **Size/performance-tuned Rust release profile** — `lto = true`, `codegen-units = 1`,
  `opt-level = "s"`, `strip = true`, `panic = "abort"`.
- **Capability-based security** (Tauri v2 `capabilities/`) — the app only gets the
  permissions it declares.
- **Signed auto-updates** — a minisign keypair + a JSON manifest served over HTTPS.

## Tech stack

Rust · Tauri 2 · `tauri-plugin-updater` · serde · NSIS · WebView2 · (frontend: Vite/React, separate)

## Project layout

```
src-tauri/
  src/main.rs            # Rust entry point + update command
  Cargo.toml             # dependencies + optimized release profile
  Cargo.lock
  build.rs
  tauri.conf.json        # window, bundle targets (nsis/appimage/deb), NSIS + updater config
  capabilities/default.json
  installer-hooks.nsh    # custom NSIS install / uninstall hooks
  installer.nsi
  icons/                 # app + installer artwork
dist/                    # tiny placeholder frontend (swap for your real web build)
package.json             # npm scripts that drive the Tauri CLI
```

## Build

Prerequisites: **Rust** (with the MSVC toolchain on Windows), **Node.js 18+**, and
**VS Build Tools** (Windows).

```bash
npm install            # installs @tauri-apps/cli
npm run tauri:dev      # run the desktop app in dev
npm run tauri:build    # produce the native bundles
```

Outputs:

| Platform | Bundle |
|----------|--------|
| Windows  | `src-tauri/target/release/bundle/nsis/*-setup.exe` |
| Linux    | `src-tauri/target/release/bundle/appimage/*.AppImage`, `.../deb/*.deb` |

## The update command (excerpt)

```rust
#[tauri::command]
async fn check_update(app: tauri::AppHandle) -> Result<String, String> {
    let updater = app.updater().map_err(|e| e.to_string())?;
    let update = match updater.check().await {
        Ok(Some(u)) => u,
        Ok(None) => return Ok("up-to-date".into()),
        Err(e) => return Err(e.to_string()),
    };
    let version = update.version.to_string();
    tauri::async_runtime::spawn(async move {
        let _ = update.download_and_install(|_c, _t| {}, || {}).await;
    });
    Ok(format!("downloading:{}", version))
}
```

---

*Built by mxgamecoder. Available for Rust / Tauri desktop work.*
