#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri_plugin_updater::UpdaterExt;

/// Checks for a Lumora desktop update and, if one is available, downloads and
/// installs it. Called from the frontend on app launch (desktop only).
#[tauri::command]
async fn lumora_check_update(app: tauri::AppHandle) -> Result<String, String> {
    let updater = app.updater().map_err(|e| e.to_string())?;
    let update = match updater.check().await {
        Ok(Some(u)) => u,
        Ok(None) => return Ok("up-to-date".into()),
        Err(e) => return Err(e.to_string()),
    };
    let version = update.version.to_string();
    // Trigger the download + install (returns immediately; progress via events).
    tauri::async_runtime::spawn(async move {
        let _ = update
            .download_and_install(|_chunk, _total| {}, || {})
            .await;
    });
    Ok(format!("downloading:{}", version))
}

fn main() {
    tauri::Builder::default()
        .plugin(tauri_plugin_updater::Builder::new().build())
        .invoke_handler(tauri::generate_handler![lumora_check_update])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}