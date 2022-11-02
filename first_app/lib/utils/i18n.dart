import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class I18n {
  final Locale locale;

  I18n(this.locale);

  static I18n of(BuildContext context) {
    return Localizations.of(context, I18n);
  }

  // ignore: prefer_final_fields
  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "selectPlant": "<Please select factory>",
      "login": "Login",
      "login_uid": "Please enter account number ",
      "login_pwd": "Please enter password number",
      'queryBarCode': 'Query BarCode',
      'machineRecords': 'Production Log Records',
      'suspected': 'Defects Records',
      'assemblyParts': 'Assembly Part Trace',
      'rawMaterial': 'Raw Material',
      'barCode': 'input barCode',
      'search': 'Search',
      'logOut': 'logOut',
      'switchLanage': 'Switch Lanage',
      'setting': 'setting',
    },
    "zh": {
      "selectPlant": "<请选择工厂>",
      "login": "登录",
      "login_uid": "请输入账号",
      "login_pwd": "请输入密码",
      'queryBarCode': '条码查询',
      'machineRecords': '加工记录',
      'suspected': '可疑品',
      'assemblyParts': '装配件',
      'rawMaterial': '原材料',
      'barCode': '请输入条码',
      'search': '查询',
      'logOut': '登出',
      'switchLanage': '切换语言',
      'setting': '设置',
    }
  };

  String get selectPlant {
    return _localizedValues[locale.languageCode]!["selectPlant"] ?? "";
  }

  String get login {
    return _localizedValues[locale.languageCode]!["login"] ?? "";
  }

  // ignore: non_constant_identifier_names
  String get login_uid {
    return _localizedValues[locale.languageCode]!["login_uid"] ?? "";
  }

  // ignore: non_constant_identifier_names
  String get login_pwd {
    return _localizedValues[locale.languageCode]!["login_pwd"] ?? "";
  }

  String get queryBarCode {
    return _localizedValues[locale.languageCode]!["queryBarCode"] ?? "";
  }

  String get machineRecords {
    return _localizedValues[locale.languageCode]!["machineRecords"] ?? "";
  }

  String get suspected {
    return _localizedValues[locale.languageCode]!["suspected"] ?? "";
  }

  String get assemblyParts {
    return _localizedValues[locale.languageCode]!["assemblyParts"] ?? "";
  }

  String get rawMaterial {
    return _localizedValues[locale.languageCode]!["rawMaterial"] ?? "";
  }

  String get barCode {
    return _localizedValues[locale.languageCode]!["barCode"] ?? "";
  }

  String get search {
    return _localizedValues[locale.languageCode]!["search"] ?? "";
  }

  String get logOut {
    return _localizedValues[locale.languageCode]!["logOut"] ?? "";
  }

  String get switchLanage {
    return _localizedValues[locale.languageCode]!["switchLanage"] ?? "";
  }

  String get setting {
    return _localizedValues[locale.languageCode]!["setting"] ?? "";
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) {
    return false;
  }

  @override
  Future<I18n> load(Locale locale) {
    return SynchronousFuture(I18n(locale));
  }

  static I18nDelegate delegate = I18nDelegate();
}
