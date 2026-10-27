import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  system,
  en,
  zh,
}

extension AppLanguageExtension on AppLanguage {
  String get storageValue {
    switch (this) {
      case AppLanguage.system:
        return 'system';
      case AppLanguage.en:
        return 'en';
      case AppLanguage.zh:
        return 'zh';
    }
  }

  Locale? get locale {
    switch (this) {
      case AppLanguage.system:
        return null;
      case AppLanguage.en:
        return const Locale('en');
      case AppLanguage.zh:
        return const Locale('zh');
    }
  }

  String label(AppLocalizations l10n) {
    switch (this) {
      case AppLanguage.system:
        return l10n.followSystem;
      case AppLanguage.en:
        return l10n.english;
      case AppLanguage.zh:
        return l10n.simplifiedChinese;
    }
  }

  static AppLanguage fromStorage(String? val) {
    switch (val) {
      case 'en':
        return AppLanguage.en;
      case 'zh':
        return AppLanguage.zh;
      default:
        return AppLanguage.system;
    }
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isZh => locale.languageCode.toLowerCase() == 'zh';

  // App Title & General
  String get appName => isZh ? '悬浮时间' : 'Floating Clock';
  String get about => isZh ? '关于' : 'About';
  String get language => isZh ? '语言' : 'Language';
  String get followSystem => isZh ? '跟随系统' : 'Follow System';
  String get english => 'English';
  String get simplifiedChinese => '简体中文';

  // Home Screen
  String get timeSources => isZh ? '时间源' : 'Time Sources';
  String get restorePresets => isZh ? '恢复预设源' : 'Restore Preset Sources';
  String get displayPrecision => isZh ? '显示精度' : 'Display Precision';
  String get precisionCentisecond => isZh ? '0.01 秒' : '0.01 s';
  String get precisionDecisecond => isZh ? '0.1 秒' : '0.1 s';
  String get fractionColor => isZh ? '小数颜色' : 'Fraction Color';

  // Fraction Colors
  String colorName(String key) {
    switch (key) {
      case 'deep_red':
        return isZh ? '暗红' : 'Deep Red';
      case 'amber':
        return isZh ? '琥珀' : 'Amber';
      case 'teal':
        return isZh ? '青绿' : 'Teal';
      case 'indigo':
        return isZh ? '靛蓝' : 'Indigo';
      case 'purple':
        return isZh ? '紫罗兰' : 'Purple';
      default:
        return key;
    }
  }

  // Preset Source Aliases
  String getPresetAlias(String host) {
    if (host == 'ntp.aliyun.com') {
      return isZh ? '阿里云' : 'Aliyun';
    } else if (host == 'ntp.tencent.com') {
      return isZh ? '腾讯' : 'Tencent';
    } else if (host.contains('cube.meituan.com')) {
      return isZh ? '美团' : 'Meituan';
    }
    return host;
  }

  String get systemTime => isZh ? '系统时间' : 'System Time';

  String lastSynced(String time) =>
      isZh ? '最近同步: $time' : 'Last sync: $time';

  // Actions
  String get startFloating => isZh ? '开始悬浮' : 'Start Floating';
  String get stopFloating => isZh ? '停止悬浮' : 'Stop Floating';
  String get pip => isZh ? '画中画' : 'PiP';

  // Dialogs & SnackBars
  String get pipNotSupported =>
      isZh ? '当前设备不支持画中画模式' : 'Picture-in-picture mode is not supported on this device';
  String get pipSettingsError => isZh
      ? '无法进入画中画模式，请检查系统设置'
      : 'Unable to enter picture-in-picture mode. Please check system settings';
  String get pipFailed =>
      isZh ? '进入画中画失败' : 'Failed to enter picture-in-picture';
  String get overlayPermissionNotice => isZh
      ? '请在系统设置允许“悬浮窗/在其他应用上层显示”权限后再次点击开始'
      : 'Please enable "Display over other apps" permission in system settings and tap start again';

  // Add / Edit NTP Server Dialog
  String get addNtpServer => isZh ? '添加 NTP 服务器' : 'Add NTP Server';
  String get editNtpServer => isZh ? '编辑 NTP 服务器' : 'Edit NTP Server';
  String get host => isZh ? '主机' : 'Host';
  String get hostHint => 'ntp.example.com';
  String get alias => isZh ? '别名' : 'Alias';
  String get aliasHint => isZh ? '可选别名' : 'Optional alias';
  String get cancel => isZh ? '取消' : 'Cancel';
  String get add => isZh ? '添加' : 'Add';
  String get save => isZh ? '保存' : 'Save';
  String get testingNtp =>
      isZh ? '正在测试 NTP 服务器...' : 'Testing NTP server...';
  String ntpFailed(String host) => isZh
      ? '无法从 $host 获取 NTP 时间，请检查主机或网络'
      : 'Unable to get NTP time from $host. Please check host or network';

  // Restore Presets Dialog
  String get noMissingPresets =>
      isZh ? '没有缺失的预设需要恢复' : 'No missing presets to restore';
  String get restorePresetsTitle =>
      isZh ? '恢复预设源' : 'Restore Preset Sources';
  String restorePresetsConfirm(String list) =>
      isZh ? '将恢复以下预设: $list' : 'The following presets will be restored: $list';
  String get restore => isZh ? '恢复' : 'Restore';

  // About Page
  String version(String v) => isZh ? '版本 $v' : 'Version $v';
  String get versionUnknown => isZh ? '未知' : 'Unknown';
  String get appDescription => isZh
      ? '一个显示并同步时间的悬浮窗应用。'
      : 'A lightweight floating clock app displaying and synchronizing accurate time.';
  String get openRepo => isZh ? '打开仓库' : 'Open Repository';
  String get copyRepo => isZh ? '复制地址' : 'Copy URL';
  String get cannotOpenLink => isZh ? '无法打开链接' : 'Unable to open link';
  String get repoCopied =>
      isZh ? '仓库地址已复制到剪贴板' : 'Repository URL copied to clipboard';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode.toLowerCase());
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class LocaleManager extends ChangeNotifier {
  static const String prefKey = 'app_language_preference';
  AppLanguage _currentLanguage = AppLanguage.system;

  AppLanguage get currentLanguage => _currentLanguage;

  Locale? get locale => _currentLanguage.locale;

  Future<void> loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(prefKey);
      _currentLanguage = AppLanguageExtension.fromStorage(saved);
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_currentLanguage == language) return;
    _currentLanguage = language;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefKey, language.storageValue);
    } catch (_) {}
  }
}

class LocaleScope extends InheritedWidget {
  final LocaleManager localeManager;

  const LocaleScope({
    super.key,
    required this.localeManager,
    required super.child,
  });

  static LocaleManager of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    return scope?.localeManager ?? LocaleManager();
  }

  @override
  bool updateShouldNotify(LocaleScope oldWidget) {
    return localeManager != oldWidget.localeManager;
  }
}
