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
      "login_error": "Login failed. Retry",
      "menu": "Menu List",
      'queryBarCode': 'Query BarCode',
      'machineRecords': 'Production Log Records',
      'suspected': 'Defects Records',
      'assemblyParts': 'Assembly Part Trace',
      'rawMaterial': 'Raw Material',
      'inputBarCode': 'input barCode',
      'search': 'Search',
      'logOut': 'LogOut',
      'theme': 'Theme',
      'switchLanage': 'Lanage',
      'setting': 'Setting',
      'barCode': 'BarCode',
      'partNo': 'Part No',
      'partName': 'Part Name',
      'state': 'Status',
      'location': 'Station',
      'generationDt': 'Production Time',
      'createDt': 'Create Time',
      'data_empty': 'Query data is empty',
    },
    "zh": {
      "selectPlant": "<请选择工厂>",
      "login": "登录",
      "login_uid": "请输入账号",
      "login_pwd": "请输入密码",
      "login_error": "登录失败，重新输入",
      "menu": "主菜单",
      'queryBarCode': '条码查询',
      'machineRecords': '加工记录',
      'suspected': '可疑品',
      'assemblyParts': '装配件',
      'rawMaterial': '原材料',
      'inputBarCode': '请输入条码',
      'search': '查询',
      'logOut': '登出',
      'theme': '主题',
      'switchLanage': '切换语言',
      'setting': '设置',
      'barCode': '条码',
      'partNo': '零件号',
      'partName': '零件名称',
      'state': '状态',
      'location': '工位',
      'generationDt': '生产时间',
      'createDt': '生产时间',
      'data_empty': '查询数据为空',
    }
  };

  String get selectPlant {
    return _localizedValues[locale.languageCode]!["selectPlant"] as String;
  }

  String get login {
    return _localizedValues[locale.languageCode]!["login"] as String;
  }

  // ignore: non_constant_identifier_names
  String get login_uid {
    return _localizedValues[locale.languageCode]!["login_uid"] as String;
  }

  // ignore: non_constant_identifier_names
  String get login_pwd {
    return _localizedValues[locale.languageCode]!["login_pwd"] as String;
  }

  // ignore: non_constant_identifier_names
  String get login_error {
    return _localizedValues[locale.languageCode]!["login_error"] as String;
  }

  String get menu {
    return _localizedValues[locale.languageCode]!["menu"] as String;
  }

  String get queryBarCode {
    return _localizedValues[locale.languageCode]!["queryBarCode"] as String;
  }

  String get machineRecords {
    return _localizedValues[locale.languageCode]!["machineRecords"] as String;
  }

  String get suspected {
    return _localizedValues[locale.languageCode]!["suspected"] as String;
  }

  String get assemblyParts {
    return _localizedValues[locale.languageCode]!["assemblyParts"] as String;
  }

  String get rawMaterial {
    return _localizedValues[locale.languageCode]!["rawMaterial"] as String;
  }

  String get inputBarCode {
    return _localizedValues[locale.languageCode]!["inputBarCode"] as String;
  }

  String get search {
    return _localizedValues[locale.languageCode]!["search"] as String;
  }

  String get logOut {
    return _localizedValues[locale.languageCode]!["logOut"] as String;
  }

  String get switchLanage {
    return _localizedValues[locale.languageCode]!["switchLanage"] as String;
  }

  String get theme {
    return _localizedValues[locale.languageCode]!["theme"] as String;
  }

  String get setting {
    return _localizedValues[locale.languageCode]!["setting"] as String;
  }

  String get barCode {
    return _localizedValues[locale.languageCode]!["barCode"] as String;
  }

  String get partNo {
    return _localizedValues[locale.languageCode]!["partNo"] as String;
  }

  String get partName {
    return _localizedValues[locale.languageCode]!["partName"] as String;
  }

  String get state {
    return _localizedValues[locale.languageCode]!["state"] as String;
  }

  String get location {
    return _localizedValues[locale.languageCode]!["location"] as String;
  }

  String get generationDt {
    return _localizedValues[locale.languageCode]!["generationDt"] as String;
  }

  String get createDt {
    return _localizedValues[locale.languageCode]!["createDt"] as String;
  }

  // ignore: non_constant_identifier_names
  String get data_empty {
    return _localizedValues[locale.languageCode]!["data_empty"] as String;
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
