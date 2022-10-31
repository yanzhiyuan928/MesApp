// ignore_for_file: prefer_const_constructors, unnecessary_this, duplicate_ignore, avoid_print, unused_import

import 'package:first_app/IndexPage.dart';
import 'package:first_app/route/routes.dart';
import 'package:first_app/utils/dioApi.dart';
import 'package:first_app/utils/i18n.dart';
import 'package:first_app/utils/kvStore.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //打开为展示线框看布局
      // showSemanticsDebugger: true,
      //Android任务管理器的标题
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      localeResolutionCallback:
          // ignore: body_might_complete_normally_nullable
          (Locale? _locale, Iterable<Locale> supportedLocales) {
        return Locale('zh');
      },
      //中英文
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        // 指定本地化的字符串和一些其他的值
        GlobalMaterialLocalizations.delegate,
        //指定默认的文本排列方向, 由左到右或由右到左
        GlobalWidgetsLocalizations.delegate,
        I18nDelegate()
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}

//StatefulWidget是有状态的widget,可以实现动态效果
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final txt_uid = TextEditingController();
  final txt_pwd = TextEditingController();
  bool showPhoneClear = false;
  bool showPwdClear = false;
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode pwdFocusNode = FocusNode();

  bool flag = true;
  List<DropdownMenuItem<String>> plantList = [];

  Future<void> load() async {
    await kvStore.init();
    await handlePlant();
    await refresh();
  }

  Future<void> handlePlant() async {
    Map<String, dynamic> params = {};
    await sendRequest(getPlant, Method.get, params).then((value) {
      print(value);
      value.forEach((el) => {
            this.plantList.add(DropdownMenuItem(
                child: Text(el['PlantName']), value: el['PlantID']))
          });
    }).catchError((error) {
      if (error) {
        print(error.toString());
      }
    });
  }

  Future<void> refresh() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  //生命周期函数
  //该回调只会调用一次，当屏幕首次渲染第一帧的时候调用
  void initState() {
    super.initState();
    load();
  }

  @override
  //生命周期函数
  //构建该widget表示的UI元素
  Widget build(BuildContext context) {
    return Scaffold(
        //避免键盘弹起遮挡输入框报错，默认为true
        // resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        // title: const Text('sss'),
        //   backgroundColor: Colors.pink,
        // ),
        body: Container(
      color: Color.fromARGB(255, 228, 240, 252),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: -100,
            right: -100,
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200)),
                color: Color.fromARGB(255, 64, 134, 255),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            height: 570,
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Text(
                      I18n.of(context).login,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      // ignore: unnecessary_this
                      onChanged: (value) => {
                        this.flag = value,
                        refresh(),
                      },
                      // ignore: unnecessary_this
                      value: this.flag,
                    ),
                  ),
                  //工厂下拉
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: DropdownButtonFormField(
                      items: plantList,
                      onChanged: (value) => {print(value)},
                      //装饰器
                      decoration: InputDecoration(
                        //手机号图标
                        prefixIcon: const Icon(
                          Icons.list,
                          size: 25,
                          color: Colors.blue,
                        ),
                        //提示文字
                        hintText: I18n.of(context).selectPlant,
                        //没有边框没有装饰线
                        // border: InputBorder.none,
                        // 边框
                        border: const OutlineInputBorder(
                          //圆角
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),

                  //登录账号
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      //关联焦点变量，处理输入框失去焦点
                      focusNode: phoneFocusNode,
                      //关联输入框变量
                      controller: txt_uid,
                      //键盘类型
                      keyboardType: TextInputType.text,
                      //输入校验
                      // inputFormatters: [
                      //   //设置只允许输入数字
                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // ],
                      //最大字符数
                      maxLength: 15,
                      //输入框获取焦点的时候
                      onTap: () {
                        setState(() {
                          showPhoneClear = true;
                          showPwdClear = false;
                        });
                      },
                      //编辑完成，点击键盘的完成按钮，
                      onEditingComplete: () {
                        print('onEditingComplete');
                        //手机号输入框失去焦点
                        phoneFocusNode.unfocus();
                        setState(() {
                          showPhoneClear = false;
                        });
                      },
                      //装饰器
                      decoration: InputDecoration(
                        //手机号图标
                        prefixIcon: const Icon(
                          Icons.login_sharp,
                          size: 25,
                          color: Colors.blue,
                        ),
                        //提示文字
                        hintText: I18n.of(context).login_uid,
                        //没有边框没有装饰线
                        // border: InputBorder.none,
                        // 边框
                        border: const OutlineInputBorder(
                          //圆角
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        //后面清除按钮和事件
                        suffixIcon: Visibility(
                          visible: showPhoneClear,
                          child: GestureDetector(
                            onTap: () {
                              txt_uid.clear();
                              print('jj');
                            },
                            //清除按钮
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //登录密码
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      focusNode: pwdFocusNode,
                      controller: txt_pwd,
                      maxLength: 32,
                      obscureText: true,
                      //这个键盘兼容密码密码输入字符
                      keyboardType: TextInputType.text,
                      onTap: () {
                        setState(() {
                          showPhoneClear = false;
                          showPwdClear = true;
                        });
                      },
                      onEditingComplete: () {
                        pwdFocusNode.unfocus();
                        setState(() {
                          showPwdClear = false;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,
                            size: 25, color: Colors.blue),
                        hintText: I18n.of(context).login_pwd,
                        suffixIcon: Visibility(
                          visible: showPwdClear,
                          child: GestureDetector(
                            onTap: () {
                              txt_pwd.clear();
                              print('jj');
                            },
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 登录按钮
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),

                        // padding:
                        // MaterialStateProperty.all(const EdgeInsets.all(25)),
                      ),
                      onPressed: () async {
                        kvStore.save('uid', txt_uid.text);
                        var tmp = await kvStore.getString('uid');
                        print(tmp);
                        kvStore.remove('uid');
                        var tmp1 = await kvStore.getString('uid');
                        print(tmp1);

                        print("登录");
                        print('手机号：${txt_uid.text}  密码：${txt_pwd.text}');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IndexPage()));
                      },
                      child: Text(
                        I18n.of(context).login,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 2 - 40,
              top: 100,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  // borderRadius: const BorderRadius.all(Radius.circular(40)),
                  shape: BoxShape.circle, //圆形
                  border: Border.all(color: Colors.white, width: 8),
                ),
              ))
        ],
      ),
    ));
  }
}
