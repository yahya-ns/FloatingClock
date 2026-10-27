<div align="center">
    <h1>悬浮时间 / Floating Clock</h1>

  <img src="./assets/home.jpg" alt="App Preview" width="45%" />
  <img src="./assets/PiP.jpg" alt="App Preview" width="45%" />
<br/>
</div>
<br/>

A lightweight Flutter application that displays a draggable floating clock overlay on Android anywhere on your screen, supporting multi-source time synchronization, offset calibration, and Picture-in-Picture (PiP).

一个使用 Flutter 编写的轻量级应用，在 Android 上可将一个可拖动的时钟以悬浮窗形式显示在屏幕任意位置，支持多源时间同步与偏差显示。

**Key Features / 主要特性**

- **Multi-language Support (i18n)**: Automatically follows device system language with an in-app toggle for English and Simplified Chinese (跟随系统 / English / 简体中文).
- **Precision Switching**: Toggle between 0.1 s and 0.01 s precision with selectable dark accent highlights (e.g., `12:34:56.7` / `12:34:56.78`).
- **Floating Overlay**: Android system overlay with drag-to-move, pin, and close controls.
- **Multi-Source Time**: Supports System, NTP, and HTTP time sources with offset (ms) comparison.
- **Auto Sync**: Periodic background synchronization with last-synced timestamp tracking.
- **Local Persistence**: Saves user-configured time sources and language preference via `shared_preferences`.
- **Picture-in-Picture (PiP)**: Supports Android Picture-in-Picture mode.

**Project Structure / 代码结构**

- `lib/main.dart`: App entry point with `LocaleManager` and `MaterialApp` localization setup.
- `lib/l10n/`: Centralized localization definitions, dictionaries, and language state management.
- `lib/pages/`: `HomePage`, `AboutPage`, and their UI state, sync timers, and platform channel integrations.
- `lib/models/`: `TimePrecision`, `TimeSource`, and serialization logic.
- `android/`: Android native overlay service (`FloatingClockService`), Picture-in-Picture handling, and localized string resources.
- `test/`: Unit & widget tests in `test/widget_test.dart`.

**Run & Test / 运行与测试**

- `flutter pub get`
- `flutter run`
- `flutter test`
