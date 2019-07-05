import 'package:flutter/material.dart';
import 'package:hypnose/app/services/categories_service.dart';
import 'package:hypnose/app/ui/widgets/category_tab_view.dart';
import 'package:provider/provider.dart';

class AdminSettingsView extends StatefulWidget {
  @override
  _AdminSettingsViewState createState() => _AdminSettingsViewState();
}

class _AdminSettingsViewState extends State<AdminSettingsView> {
  TextEditingController addCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var categoryService = Provider.of<CategoriesService>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Pictures',
              ),
              Tab(
                text: 'Audios',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoryTabView(isAudio: false, categoryService: categoryService),
            CategoryTabView(
              categoryService: categoryService,
              isAudio: true,
            ),
          ],
        ),
      ),
    );
  }
}
