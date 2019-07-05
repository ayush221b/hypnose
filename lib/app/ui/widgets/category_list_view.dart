import 'package:flutter/material.dart';
import 'package:hypnose/app/services/categories_service.dart';
import 'package:provider/provider.dart';

class CategoryListView extends StatelessWidget {
  final bool isAudio;

  const CategoryListView({@required this.isAudio});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesService>(
      builder: (BuildContext context, CategoriesService categoriesService,
          Widget child) {
        return Expanded(
          child: StreamBuilder(
            initialData: [],
            stream: isAudio
                ? categoriesService.getAudioCategories()
                : categoriesService.getPictureCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                      width: 300,
                      child: Text('No Categories Added. Please add some.')),
                );
              } else {
                List categories = snapshot.data.toList();
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Material(
                        elevation: 4,
                        child: ListTile(
                          leading: Text('${index + 1}.'),
                          title: Text('${categories[index]['title']}'),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
