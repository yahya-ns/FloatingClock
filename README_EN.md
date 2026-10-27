<div align="center">
  <h1>Floating Clock</h1>

  <p>
    <b>English</b> | 
    <a href="README_CN.md">简体中文</a> | 
    <a href="README.md">Bahasa Indonesia</a>
  </p>

  <img src="./assets/home.jpeg" alt="App Preview" width="45%" />
  <img src="./assets/PIP.jpeg" alt="Picture-in-Picture Mode" width="45%" />
  <br/>
</div>
<br/>

A lightweight Flutter application that displays a draggable floating clock overlay on Android anywhere on your screen, supporting multi-source time synchronization, offset calibration, and Picture-in-Picture (PiP).

---

### ✨ Key Features

- **Floating Clock Overlay**: Draggable Android system overlay with drag-to-move, pin position, and quick close controls.
- **Picture-in-Picture (PiP)**: Supports native Android Picture-in-Picture mode for showing time in a floating system window.
- **Multi-Source Time Synchronization**: Supports System Time, **NTP** (*Network Time Protocol*), and **HTTP** time endpoints with offset calculation (in milliseconds).
- **Default Indonesian & Global NTP Presets**: Pre-configured with reliable and fast NTP servers:
  - `id.pool.ntp.org` (NTP Pool Indonesia)
  - `time.google.com` (Google NTP)
  - `time.cloudflare.com` (Cloudflare NTP)
  - `pool.ntp.org` (Global Pool NTP)
- **Time Precision Switching**: Toggle between **0.1 s** (`12:34:56.7`) and **0.01 s** (`12:34:56.78`) precision with customizable accent highlight colors for fraction digits.
- **Periodic Background Sync**: Automatically updates and recalibrates time offsets periodically with last-synced timestamp tracking.
- **Local Persistence**: Saves user-configured custom NTP servers, presets, and preferences locally using `shared_preferences`.
- **Multi-language Support (i18n)**: Automatically follows device system language with an in-app toggle for English and Simplified Chinese (跟随系统 / English / 简体中文).

---

### 📁 Project Structure

- `lib/main.dart`: App entry point with `LocaleManager` and `MaterialApp` localization setup.
- `lib/l10n/`: Centralized localization definitions, dictionaries, and language state management.
- `lib/pages/`: 
  - `HomePage`: Main dashboard, time sources management, sync timers, and overlay controls.
  - `AboutPage`: App version, details, and legal information.
- `lib/models/`: Data models (`TimeSource`, `TimePrecision`) and JSON serialization logic.
- `android/`: Android native code for the system overlay service (`FloatingClockService`), Picture-in-Picture handling, and MethodChannel integrations.
- `test/`: Unit & widget tests in `test/widget_test.dart`.

---

### 🚀 Getting Started & Build

Make sure you have Flutter SDK and Android SDK installed on your machine.

```bash
# Fetch dependencies
flutter pub get

# Run on a connected device or emulator
flutter run

# Run tests
flutter test

# Build optimized release APKs (split per ABI with obfuscation)
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/symbols
```
