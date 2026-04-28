# PowerShell Scripts

A personal collection of PowerShell automation scripts for file management, backups, system utilities, and general workflow improvement.

These scripts are designed for practical use in real environments such as:
- file backups
- development workflows
- system automation
- quick utilities for Windows

---

## Requirements

Most scripts require:
- Windows 10/11
- PowerShell 5.1+ or PowerShell 7+
- Optional dependencies depending on script

---

## Usage

Run scripts from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scriptname.ps1
```
Some scripts may require editing configuration variables at the top (paths, folders, etc.).

---

## Included Scripts

### copypastebutbetter.ps1
Utility tool that:
* Compresses folders with 7zip
* Moves archives using Robocopy
* Uses staging directories for safe transfers
* Cleans up after successful transfer

---

## Notes
* These scripts are primarily for personal utility
* Expect inconsistent updates

---

## License
MIT License – see `LICENSE` file.
