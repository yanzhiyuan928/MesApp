import 'package:first_app/utils/changeNotifier.dart';
import 'package:first_app/utils/dioApi.dart';
import 'package:first_app/utils/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:first_app/utils/kvStore.dart';
import 'package:provider/provider.dart';

//有状态
class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCodePage> {
  final txtBarCode = TextEditingController();
  bool showClear = false;
  final FocusNode barCodeFocusNode = FocusNode();
  String plantID = '', identifyID = '';

  //状态中英文
  final Map _mapStatus = {
    0: 'Create',
    1: 'complete',
    10: 'Experiment piece',
    11: 'Shipped',
    12: 'Cancel shipment',
    13: 'Already loading',
    14: 'Customer receiving',
    15: 'Reworking',
    16: 'Pending Judgement',
    17: 'To Be Repaired',
    2: 'Unknown',
    20: 'Reworking',
    21: 'Reworked',
    23: 'Block',
    3: 'Scrap',
    4: 'report',
    5: 'Assembly disassembly',
    6: 'Be assembled',
    7: 'Disassembled',
    8: 'Suspicious article',
    9: 'Suspective parts to normal'
  };

  late var labBarCode = '',
      labPartNo = '',
      labPartName = '',
      labStatus = '',
      labStation = '',
      labProductDt = '',
      labCreateDt = '';

  @override
  //生命周期函数
  //该回调只会调用一次，当屏幕首次渲染第一帧的时候调用
  void initState() {
    super.initState();
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
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    I18n.of(context).barCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labBarCode),
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
                  child: Text(
                    I18n.of(context).partNo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labPartNo),
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
                  child: Text(
                    I18n.of(context).partName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labPartName),
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
                  child: Text(
                    I18n.of(context).state,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labStatus),
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
                  child: Text(
                    I18n.of(context).location,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labStation),
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
                  child: Text(
                    I18n.of(context).generationDt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labProductDt),
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
                  child: Text(
                    I18n.of(context).createDt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(labCreateDt),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
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
    });
  }

  Future<void> getData(
      String barCode, String plantId, String identifyID) async {
    Map<String, dynamic> params = {
      'barcode': barCode,
      'plantID': plantId,
      'identifyID': identifyID
    };
    await sendRequest(getBarcodeInfo, Method.get, params).then((value) {
      if (value.length == 0) {
        txtBarCode.text = '';
        return;
      }
      print(value);
      if (!mounted) return;

      setState(() {
        print(_mapStatus[1]);
        var _lanage =
            Provider.of<LanageProvider>(context, listen: false).getLanage;

        value.forEach((el) => {
              labBarCode = el['BARCODE'],
              labPartNo = el['PART_NO'],
              labPartName = el['PART_NAME'],
              labStatus = _mapStatus[el['STATUS']],
              if (_lanage == 'zh') {labStatus = el['STATUSNAME']},
              labStation = el['LOCATION'],
              labProductDt = el['GENERATION_TIME'],
              labCreateDt = el['CREATE_DATE']
            });
      });
    }).catchError((error) {
      if (error) {
        print(error.toString());
      }
    });
  }
}
