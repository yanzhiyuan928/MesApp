// ignore: file_names
import 'package:first_app/utils/i18n.dart';
import 'package:flutter/material.dart';
import 'home_card.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await refresh();
  }

  // 通知界面刷新
  Future<void> refresh() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          HomeCard(
            text: I18n.of(context).queryBarCode,
            routeName: '/queryBarCode',
          ),
          HomeCard(
            text: I18n.of(context).machineRecords,
            routeName: '',
          ),
          HomeCard(
            text: I18n.of(context).suspected,
            routeName: '',
          ),
          HomeCard(
            text: I18n.of(context).assemblyParts,
            routeName: '',
          ),
          HomeCard(
            text: I18n.of(context).rawMaterial,
            routeName: '',
          )
        ],
      ),
    );
  }
}
