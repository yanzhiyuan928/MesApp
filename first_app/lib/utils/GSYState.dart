// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';

// ///全局Redux store 的对象，保存State数据
// class GSYState {
//   ///主题
//   ThemeData themeData;

//   ///语言
//   Locale locale;

//   ///构造方法
//   GSYState({required this.themeData, required this.locale});
// }

// ///创建 Reducer
// ///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
// ///我们自定义了 appReducer 用于创建 store
// GSYState appReducer(GSYState state, action) {
//   return GSYState(
//     ///通过自定义 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
//     themeData: themeDataReducer(state.themeData, action),

//     ///通过自定义 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
//     locale: localeReducer(state.locale, action),
//   );
// }

// //#################### 主题 #########################

// ///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
// final themeDataReducer = combineReducers<ThemeData>([
//   ///将Action，处理Action动作的方法，State绑定
//   TypedReducer<ThemeData, RefreshThemeDataAction>(_refreshTheme),
// ]);

// ///定义处理 Action 行为的方法，返回新的 State
// ThemeData _refreshTheme(ThemeData themeData, action) {
//   themeData = action.themeData;
//   return themeData;
// }

// ///定义一个 Action 类
// ///将该 Action 在 Reducer 中与处理该Action的方法绑定
// class RefreshThemeDataAction {
//   final ThemeData themeData;

//   RefreshThemeDataAction(this.themeData);
// }

// //#################### 国际化 #########################

// ///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
// final localeReducer = combineReducers<Locale>([
//   ///将Action，处理Action动作的方法，State绑定
//   TypedReducer<Locale, RefreshLocaleAction>(_refreshLocale),
// ]);

// ///定义处理 Action 行为的方法，返回新的 State
// Locale _refreshLocale(Locale locale, action) {
//   locale = action.locale;
//   return locale;
// }

// ///定义一个 Action 类
// ///将该 Action 在 Reducer 中与处理该Action的方法绑定
// class RefreshLocaleAction {
//   final Locale localeData;

//   RefreshLocaleAction(this.localeData);
// }
