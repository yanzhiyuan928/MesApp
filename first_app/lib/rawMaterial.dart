// ignore_for_file: camel_case_types, avoid_print

import 'package:first_app/utils/dioApi.dart';
import 'package:first_app/utils/i18n.dart';
import 'package:first_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:first_app/utils/kvStore.dart';

//有状态
class rawMaterialPage extends StatefulWidget {
  const rawMaterialPage({Key? key}) : super(key: key);

  @override
  State<rawMaterialPage> createState() => _rawMaterialState();
}

class _rawMaterialState extends State<rawMaterialPage> {
  final txtBarCode = TextEditingController();
  bool showClear = false;
  final FocusNode barCodeFocusNode = FocusNode();
  String plantID = '', identifyID = '';

  late var resLst = [];

  @override
  //生命周期函数
  //该回调只会调用一次，当屏幕首次渲染第一帧的时候调用
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    plantID = await kvStore.getString('plantID') as String;
    identifyID = await kvStore.getString('identifyID') as String;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context)!.settings.arguments.toString()),
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    autofocus: true,
                    focusNode: barCodeFocusNode,
                    controller: txtBarCode,
                    //maxLength: 36,
                    keyboardType: TextInputType.text,
                    onTap: () {
                      setState(() {
                        showClear = true;
                      });
                    },
                    onEditingComplete: () {
                      barCodeFocusNode.unfocus();
                      setState(() {
                        showClear = false;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.qr_code,
                          size: 25, color: Colors.blue),
                      prefixIconConstraints: const BoxConstraints(),
                      hintText: I18n.of(context).inputBarCode,
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
                      //backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                    ),
                    onPressed: () async {
                      await getData(txtBarCode.text);
                    },
                    child: Text(
                      I18n.of(context).search,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 30,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          //backgroundColor: MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                        ),
                        onPressed: () async {
                          scanBarcodeNormal();
                        },
                        child: const Icon(Icons.camera_alt_sharp)),
                  )),
              Container(
                margin: const EdgeInsets.only(right: 10.0),
              ),
            ],
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(
            margin: const EdgeInsets.all(4),
            height: 500,
            child: ListView(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _listView()),
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      txtBarCode.clear();
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (barcodeScanRes == '-1') {
        return;
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      txtBarCode.text = barcodeScanRes;
      getData(txtBarCode.text);
    });
  }

  Future<void> getData(String barCode) async {
    Map<String, dynamic> params = {
      'barcode': barCode,
      'plantID': plantID,
      'identifyID': identifyID
    };
    await sendRequest(getRawMaterial, Method.get, params).then((value) {
      print(value);
      if (value.length == 0 || value[0]['ERROR'] != null) {
        showErrorToast(msg: I18n.of(context).data_empty);
        txtBarCode.clear();
        return;
      }

      if (!mounted) return;

      setState(() {
        resLst = value;
      });
    }).catchError((error) {
      if (error) {
        print(error.toString());
        showErrorToast(msg: error.toString());
      }
    });
  }

  List<Widget> _listView() {
    return resLst
        .map((item) => Card(
              elevation: 10.0, //设置阴影
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: Text('BatchNo.: ' + item['BATCH_CODE'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PartNo: ' + item['PartNo']),
                        Text('PartName: ' + item['PartName']),
                      ],
                    ),
                  )
                ],
              ),
            ))
        .toList();
  }
}
