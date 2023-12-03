// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/HiveDatabase.dart';
import 'package:flutter_application_9/pages/addNotePage.dart';
import 'package:flutter_application_9/ui_helpers/notesUiHelper.dart';

// ignore: must_be_immutable
class FloatingActionButtons extends StatelessWidget {
  FloatingActionButtons({
    super.key,
  });
  
  late String category="";
  var keyform=GlobalKey<FormFieldState>();
  HiveDatabase database=HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.small(
          heroTag: "btn1",
          onPressed: () {
            categoryShowDialog(context);
          },
          child: const Icon(Icons.menu_book_rounded),
        ),
        const SizedBox(
          height: 2,
        ),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () {
            if(database.categoryIsEmpty()){
              categoryShowDialog(context,ctgIsEmpty: true);
            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AddNotePage(),));
            }
            
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Future<dynamic> categoryShowDialog(BuildContext context,{bool ctgIsEmpty=false}) {
    return showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  "addCategory",
                  style: noteUiHelper.noteTitleTextStyle,
                ).tr(),
                children: [
                  TextFormField(
                    key: keyform,
                    validator: (value) {
                      if(value!.length<2){
                        return "addCategoryValidate".tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      category=value!.toLowerCase();                  
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: ctgIsEmpty==true?"addEmptyCategory".tr():"",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: () {
                    bool validate=keyform.currentState!.validate();
                    if(validate){
                      keyform.currentState!.save();
                      database.addCategory(category);
                      Navigator.of(context).pop();
                    }
                  }, child: const Text("addCategoryBTN").tr())
                ],
              );
            },
          );
  }
}
