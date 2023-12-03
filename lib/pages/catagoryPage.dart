// ignore_for_file: file_names, non_constant_identifier_names, avoid_unnecessary_containers, sort_child_properties_last

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/HiveDatabase.dart';
import 'package:flutter_application_9/pages/homePage.dart';
import 'package:flutter_application_9/ui_helpers/notesUiHelper.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  Set categories = {};
  HiveDatabase database = HiveDatabase();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categories = database.getAllCategory();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("categoryAppbar").tr(),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back_outlined),onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage(),));
        },),
      ),
      body:categories.isEmpty? EmptyCategoryList(): CategoryList(),
    );
  }

  Center EmptyCategoryList() => Center(child: Text("categoryEmptyList",style: noteUiHelper.emptyListTextStyle,).tr(),);

  Container CategoryList() {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var nt = categories.elementAt(index);
          return ListTile(
            leading: Icon(
              Icons.menu_book_rounded,
              color: Colors.grey.shade700,
            ),
            title: Text(
              nt,
              style: noteUiHelper.noteTitleTextStyle,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.orange,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        "removeCategoryTitle",
                        style: noteUiHelper.categoryDeleteTextStyle,
                      ).tr(),
                      children: [
                        const Divider(
                          color: Colors.red,
                        ),
                        Text(
                            "removeCategoryContent",
                            style: noteUiHelper.deleteCategoryTextStyle).tr(),
                        ButtonBar(
                          children: [
                            OutlinedButton(
                                child: const Text(
                                  "removeCategoryDeleteBTN",
                                  style: TextStyle(color: Colors.red),
                                ).tr(),
                                onPressed: () {
                                  setState(() {
                                    database.deleteCategory(nt);
                                    Navigator.of(context).pop();
                                  });
                                },
                                style:
                                    noteUiHelper.DeleteCategoryButtonStyle),
                            OutlinedButton(
                                child: Text(
                                  "removeCategoryGiveupBTN",
                                  style: noteUiHelper.noteSubtitleTextStyle,
                                ).tr(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: noteUiHelper.updateButtonStyle),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
