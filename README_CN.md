<div align="center">
  <h1>悬浮时间 / Floating Clock</h1>

  <p>
    <a href="README_EN.md">English</a> | 
    <b>简体中文</b> | 
    <a href="README.md">Bahasa Indonesia</a>
  </p>

  <img src="./assets/home.jpeg" alt="应用预览" width="45%" />
  <img src="./assets/PIP.jpeg" alt="画中画模式" width="45%" />
  <br/>
</div>
<br/>

一个使用 Flutter 编写的轻量级 Android 应用，可将一个可拖动的时钟以悬浮窗形式显示在屏幕任意位置，支持多源时间同步、偏差校准以及画中画（PiP）模式。

---

### ✨ 主要特性

- **全局悬浮窗（Floating Overlay）**：Android 系统级悬浮窗口，支持任意拖动（drag-to-move）、锁定位置（pin）以及快捷关闭。
- **画中画模式（PiP）**：支持 Android 原生画中画窗口显示时钟。
- **多源时间同步**：支持系统时间、**NTP**（网络时间协议）以及 **HTTP** 时间源，精准计算并显示相对系统时间的偏差值（毫秒）。
- **内置可靠 NTP 预设**：预装全球及印尼高速稳定的 NTP 服务器：
  - `id.pool.ntp.org` (印尼 NTP 池)
  - `time.google.com` (Google NTP)
  - `time.cloudflare.com` (Cloudflare NTP)
  - `pool.ntp.org` (全球 NTP 池)
- **时间精度切换**：支持在 **0.1 秒**（`12:34:56.7`）与 **0.01 秒**（`12:34:56.78`）之间切换，并支持为毫秒部分自选高亮颜色。
- **定时后台同步**：后台定期自动校准时间偏差，并记录最近同步时间。
- **本地持久化**：使用 `shared_preferences` 自动保存自定义服务器、隐藏预设以及个性化设置。
- **多语言支持（i18n）**：自动跟随系统语言，应用内支持在英文与简体中文之间切换。

---

### 📁 代码结构

- `lib/main.dart`：应用入口，包含 `LocaleManager` 语言管理及全局主题配置。
- `lib/l10n/`：国际化本地化字典与语言状态管理。
- `lib/pages/`：
  - `HomePage`：主页面，包含时间源列表、同步定时器及悬浮窗交互。
  - `AboutPage`：关于页面，展示版本号与应用信息。
- `lib/models/`：数据模型（`TimeSource`、`TimePrecision`）及 JSON 序列化逻辑。
- `android/`：Android 原生层实现，包括原生悬浮窗服务（`FloatingClockService`）、画中画处理及 MethodChannel 通信。
- `test/`：单元测试与控件测试（`test/widget_test.dart`）。

---

### 🚀 运行与构建

确保开发环境已配置 Flutter SDK 与 Android SDK。

```bash
# 获取项目依赖
flutter pub get

# 在已连接的设备或模拟器上运行
flutter run

# 运行测试用例
flutter test

# 构建精简 release APK（分架构打包与混淆优化）
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/symbols
```
