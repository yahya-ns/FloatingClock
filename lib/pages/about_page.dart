import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter/services.dart' show Clipboard, ClipboardData, MethodChannel;
import 'package:url_launcher/url_launcher.dart';
import 'package:floating_clock/l10n/app_localizations.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';
  final String _repoUrl = 'https://github.com/yahya-ns/FloatingClock';
  bool _loading = false;
  Uint8List? _iconBytes;
  final ImageProvider _fallbackIcon = const AssetImage('assets/app_icon.webp');

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _loadIcon();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 预先加载应用图标资产，避免初始闪烁到默认占位
    precacheImage(_fallbackIcon, context);
  }

  Future<void> _loadIcon() async {
    try {
      final channel = MethodChannel('floating_clock');
      final res = await channel.invokeMethod<dynamic>('getAppIcon');
      if (res != null) {
        if (res is Uint8List) {
          setState(() => _iconBytes = res);
        } else if (res is List) {
          setState(() => _iconBytes = Uint8List.fromList(List<int>.from(res)));
        }
      }
    } catch (_) {
      // ignore
    }
  }

  Future<void> _loadVersion() async {
    setState(() => _loading = true);
    try {
      final channel = MethodChannel('floating_clock');
      final v = await channel.invokeMethod<String>('getAppVersion');
      if (v != null && v.isNotEmpty) {
        setState(() => _version = v);
      }
    } catch (_) {
      // ignore errors and leave version empty
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _openRepo(AppLocalizations l10n) async {
    final uri = Uri.parse(_repoUrl);
    try {
      final can = await canLaunchUrl(uri);
      if (!can) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.cannotOpenLink)));
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.cannotOpenLink)));
    }
  }

  void _copyRepo(AppLocalizations l10n) {
    Clipboard.setData(ClipboardData(text: _repoUrl)).then((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.repoCopied)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeManager = LocaleScope.of(context);
    final displayedVersion = _version.isNotEmpty ? _version : l10n.versionUnknown;

    final iconWidget = ClipOval(
      child: _iconBytes != null
          ? Image.memory(
              _iconBytes!,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            )
          : Image(
              image: _fallbackIcon,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  iconWidget,
                  const SizedBox(height: 12),
                  Text(l10n.appName,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  if (_loading)
                    const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  if (!_loading)
                    Text(l10n.version(displayedVersion),
                        style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 12),
                  Text(l10n.appDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _openRepo(l10n),
                        icon: const Icon(Icons.open_in_new),
                        label: Text(l10n.openRepo),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _copyRepo(l10n),
                        icon: const Icon(Icons.copy),
                        label: Text(l10n.copyRepo),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.language, color: Colors.blueGrey, size: 20),
                          const SizedBox(width: 8),
                          Text(l10n.language,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DropdownButton<AppLanguage>(
                        value: localeManager.currentLanguage,
                        underline: const SizedBox(),
                        items: AppLanguage.values.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang.label(l10n)),
                          );
                        }).toList(),
                        onChanged: (lang) {
                          if (lang != null) {
                            localeManager.setLanguage(lang);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
