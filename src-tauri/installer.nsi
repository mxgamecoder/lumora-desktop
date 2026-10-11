; Lumora 1.2 — minimal Windows installer
; Cross-compiled from Linux via cargo-xwin + NSIS
Unicode True
SetCompressor /SOLID lzma
SetDatablockOptimize on
SetDateSave off
SetOverwrite ifnewer

Name "Lumora"
OutFile "Lumora_1.2.4_x64-setup.exe"
InstallDir "$PROGRAMFILES64\Lumora"
RequestExecutionLevel user

!define PRODUCT_NAME "Lumora 1.2"
!define PRODUCT_VERSION "1.2.4"

VIProductVersion "${PRODUCT_VERSION}.0"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "LegalCopyright" "© 2026 Lumora"

; Modern UI
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "icons\icon.ico"
!define MUI_UNICON "icons\icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "icons\header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "icons\sidebar.bmp"

!define MUI_WELCOMEPAGE_TITLE "${PRODUCT_NAME} Setup"
!define MUI_WELCOMEPAGE_TEXT "This wizard will install ${PRODUCT_NAME} on your computer."
!define MUI_FINISHPAGE_TITLE "${PRODUCT_NAME} Installed"
!define MUI_FINISHPAGE_TEXT "${PRODUCT_NAME} has been installed on your computer."

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  File "lumora.exe"
  File "MicrosoftEdgeWebview2Setup.exe"
  SetOutPath "$INSTDIR\icons"
  File "icons\icon.ico"
  SetOutPath "$INSTDIR"
  ; Create desktop shortcut
  CreateDirectory "$SMPROGRAMS\Lumora"
  CreateShortcut "$SMPROGRAMS\Lumora\Lumora 1.2.lnk" "$INSTDIR\lumora.exe"
  CreateShortcut "$DESKTOP\Lumora 1.2.lnk" "$INSTDIR\lumora.exe"
  ; Registry entries for uninstaller
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Lumora" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Lumora" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Lumora" "Publisher" "Lumora"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Lumora" "UninstallString" "$INSTDIR\uninst.exe"
  WriteUninstaller "$INSTDIR\uninst.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\lumora.exe"
  Delete "$INSTDIR\MicrosoftEdgeWebview2Setup.exe"
  Delete "$INSTDIR\icons\icon.ico"
  Delete "$SMPROGRAMS\Lumora\Lumora 1.2.lnk"
  Delete "$DESKTOP\Lumora 1.2.lnk"
  RMDir "$SMPROGRAMS\Lumora"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Lumora"
SectionEnd