// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, unused_element
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

//有状态
class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCodePage> {
  final txtBarCode = TextEditingController();
  bool showClear = false;
  final FocusNode pwdFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('123123'),
        elevation: 0,
        leading: const BackButton(),
      ),
      body: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    focusNode: pwdFocusNode,
                    controller: txtBarCode,
                    maxLength: 32,
                    keyboardType: TextInputType.text,
                    onTap: () {
                      setState(() {
                        showClear = true;
                      });
                    },
                    onEditingComplete: () {
                      pwdFocusNode.unfocus();
                      setState(() {
                        showClear = false;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.fullscreen_sharp,
                          size: 25, color: Colors.blue),
                      hintText: '条码',
                      suffixIcon: Visibility(
                        visible: showClear,
                        child: GestureDetector(
                          onTap: () {
                            txtBarCode.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                // ignore: sized_box_for_whitespace
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: () async {},
                    child: const Text(
                      '查询',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: () async {
                      getQrcodeState().then((value) =>
                          setState((() => {txtBarCode.text = value})));
                    },
                    child: const Icon(Icons.camera_alt_sharp)),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10.0),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '条码：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '零件号：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '零件名称：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '状态：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '工位：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '生产时间：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    '创建时间：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text('data'),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  //扫描二维码
  static Future<String> getQrcodeState() async {
    try {
      const ScanOptions options = ScanOptions(
        strings: {
          'cancel': '取消',
          'flash_on': '开启闪光灯',
          'flash_off': '关闭闪光灯',
        },
      );
      final ScanResult result = await BarcodeScanner.scan(options: options);
      return result.rawContent;
    } catch (e) {}
    return '';
  }
}
