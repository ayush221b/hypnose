import 'package:flutter/material.dart';
import 'package:hypnose/app/services/categories_service.dart';
import 'package:hypnose/app/ui/widgets/category_list_view.dart';

class CategoryTabView extends StatefulWidget {
  const CategoryTabView({
    Key key,
    @required this.isAudio,
    @required this.categoryService,
  }) : super(key: key);

  final CategoriesService categoryService;
  final bool isAudio;

  @override
  _CategoryTabViewState createState() => _CategoryTabViewState();
}

class _CategoryTabViewState extends State<CategoryTabView> {
  final TextEditingController addCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: addCategory,
            decoration: InputDecoration(
                labelText: 'Add a Category',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    Map<String, dynamic> map =
                        widget.categoryService.newCategoryMap;
                    map['type'] = widget.isAudio ? 'audio' : 'picture';
                    map['title'] = addCategory.text;
                    map['dateTime'] = DateTime.now();

                    widget.categoryService.newCategoryMap = map;

                    bool wasAdded =
                        await widget.categoryService.addNewcategory();
                    print(wasAdded);
                    if (wasAdded) {
                      addCategory.clear();
                    }
                  },
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
          ),
        ),
        CategoryListView(isAudio: widget.isAudio),
      ],
    );
  }
}