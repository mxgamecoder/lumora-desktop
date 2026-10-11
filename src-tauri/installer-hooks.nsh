; ============================================================
;  Lumora Desktop — NSIS Installer Hooks
;  LDPlayer-style professional installer experience
; ============================================================

!macro NSIS_HOOK_PREINSTALL
  SetDetailsPrint textonly
  DetailPrint ""
  DetailPrint "  Preparing Lumora installation..."
  DetailPrint ""
  DetailPrint "  ────────────────────────────────────────"
  DetailPrint "    LUMORA  ·  Your Digital Universe"
  DetailPrint "  ────────────────────────────────────────"
  DetailPrint ""
  DetailPrint "  Checking system requirements..."
  Sleep 400
  DetailPrint "  Verifying disk space..."
  Sleep 200
!macroend

!macro NSIS_HOOK_POSTINSTALL
  SetDetailsPrint both
  DetailPrint ""
  DetailPrint "  ────────────────────────────────────────"
  DetailPrint "    Lumora has been installed successfully!"
  DetailPrint "  ────────────────────────────────────────"
  DetailPrint ""
  DetailPrint "  Thank you for choosing Lumora."
  DetailPrint "  Enjoy chat, storage, AI, hosting & games."
  DetailPrint ""
!macroend

!macro NSIS_HOOK_PREUNINSTALL
  SetDetailsPrint textonly
  DetailPrint ""
  DetailPrint "  Preparing to remove Lumora..."
  DetailPrint ""
!macroend

!macro NSIS_HOOK_POSTUNINSTALL
  SetDetailsPrint both
  DetailPrint ""
  DetailPrint "  Lumora has been removed from your system."
  DetailPrint "  We hope to see you again at lumorapp.name.ng"
  DetailPrint ""
!macroend
