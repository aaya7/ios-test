import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';

import 'language_files/en_US.dart';
import 'language_files/ms_MY.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('en', 'US');
  // static final locale = Locale('ms', 'MY');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en', 'US');
  // static final fallbackLocale = Locale('ms', 'MY');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Bahasa Malaysia',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('ms', 'MY'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    'ms_MY': malaysia,
  };

  // Gets locale from language, and updates the locale
  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    LocalDBService.instance.setLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}