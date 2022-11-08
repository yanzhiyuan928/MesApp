// ignore_for_file: camel_case_types, avoid_print

import 'package:first_app/utils/dioApi.dart';
import 'package:first_app/utils/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:first_app/utils/kvStore.dart';

//有状态
class defectInfoPage extends StatefulWidget {
  const defectInfoPage({Key? key}) : super(key: key);

  @override
  State<defectInfoPage> createState() => _defectInfoState();
}

class _defectInfoState extends State<defectInfoPage> {
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
                      prefixIcon: const Icon(Icons.fullscreen_sharp,
                          size: 25, color: Colors.blue),
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
                      plantID = await kvStore.getString('plantID') as String;
                      identifyID =
                          await kvStore.getString('identifyID') as String;
                      await getData(txtBarCode.text, plantID, identifyID);
                    },
                    child: Text(
                      I18n.of(context).search,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      txtBarCode.text = barcodeScanRes;
    });
  }

  Future<void> getData(
      String barCode, String plantId, String identifyID) async {
    Map<String, dynamic> params = {
      'barcode': barCode,
      'plantID': plantId,
      'identifyID': identifyID
    };
    await sendRequest(getDefectInfo, Method.get, params).then((value) {
      print(value);
      if (value.length == 0 || value[0]['ERROR'] != null) {
        return;
      }

      if (!mounted) return;

      setState(() {
        resLst = value;
      });
    }).catchError((error) {
      if (error) {
        print(error.toString());
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
                    title: Text('PartNo: ' + item['PART_NO'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Area: ' + item['DEFECT_LOCATION']),
                        Text('DefectType: ' + item['DEFECT_TYPE']),
                        Text('DefectResponsibilit: ' +
                            item['DEFECT_RESPONSIBILIT']),
                      ],
                    ),
                  )
                ],
              ),
            ))
        .toList();
  }
}
