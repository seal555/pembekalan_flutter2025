// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "dashboard_menu": "Dashboard Menu",
  "administrator": "Administrator",
  "settings": "Settings",
  "language_setting": "Language Settings",
  "theme_settings": "Theme Settings",
  "tnc": "Term & Conditions",
  "bahasa_indonesia": "Bahasa",
  "bahasa_inggris": "English Language"
};
static const Map<String,dynamic> id = {
  "dashboard_menu": "Menu Dasbor",
  "administrator": "Administrasi",
  "settings": "Pengaturan",
  "language_setting": "Pengaturan Bahasa",
  "theme_settings": "Pengaturan Tema",
  "tnc": "Kondisi & Peraturan",
  "bahasa_indonesia": "Bahasa Indonesia",
  "bahasa_inggris": "Bahasa Inggris"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "id": id};
}
