// ignore: file_names
// ignore_for_file: unused_element, avoid_print

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
        //automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: _buildBody(),
      drawer: _drawer,
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          HomeCard(
              text: I18n.of(context).queryBarCode, routeName: '/barCodeInfo'),
          HomeCard(
            text: I18n.of(context).machineRecords,
            routeName: '/productionLog',
          ),
          HomeCard(
            text: I18n.of(context).suspected,
            routeName: '/defectInfo',
          ),
          HomeCard(
            text: I18n.of(context).assemblyParts,
            routeName: '/assemblyPartTrack',
          ),
          HomeCard(
            text: I18n.of(context).rawMaterial,
            routeName: '/rawMaterial',
          )
        ],
      ),
    );
  }

  get _drawer => Drawer(
        ///edit start
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ignore: prefer_const_constructors
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: const Center(
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    child: Text('Admin'),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(I18n.of(context).setting),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(I18n.of(context).switchLanage),
              onTap: () {
                print('Switch Lanage');
                // ignore: unused_local_variable
                var tmpLanage = Localizations.localeOf(context);
                print(tmpLanage);
                //localeResolutionCallback
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(I18n.of(context).logOut),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/login", ModalRoute.withName("/login"));
              },
            )
          ],
        ),

        ///edit end
      );
}
