

// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/HiveDatabase.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/pages/homePage.dart';
import 'package:flutter_application_9/ui_helpers/ColorHelpers.dart';
import 'package:flutter_application_9/ui_helpers/notesUiHelper.dart';

// ignore: must_be_immutable
class AddNoteForm extends StatefulWidget {
  Note? nt=Note.create(content: "",title: "");
  AddNoteForm({Note? note,super.key}){
    nt=note;
  }

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  HiveDatabase database = HiveDatabase();

  late String NoteCategory ;
  late int NoteLevel;
  late String NoteTitle;
  late String NoteContent;
  var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
     NoteCategory = widget.nt==null? getFirstCategory(): widget.nt!.catagory;
     NoteLevel= widget.nt==null? 1 :widget.nt!.importantLevel;
     NoteTitle="";
     NoteContent="";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "addNoteCategoryDropdown",
                  style: noteUiHelper.noteTitleTextStyle,
                ).tr(),
                const SizedBox(width: 15,),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    
                    border: Border.all(width: 2,color: ColorHelper.primarySwatch),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    value: NoteCategory,
                    items: itemsCategoies(),
                    onChanged: (value) {
                      setState(() {
                        NoteCategory = value;
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            TextFormField(
              initialValue:  widget.nt==null? "":widget.nt!.title,
              style: noteUiHelper.noteTitleTextStyle,
              decoration: InputDecoration(
                  hintText: "addNoteTitleHint".tr(),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              validator: (value) {
                return null;
              },
              onSaved: (newValue) {
                NoteTitle=newValue!;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              initialValue:  widget.nt==null? "":widget.nt!.content,
              style: noteUiHelper.contentTextStyle,
              maxLines: 7,
              minLines: 3,
              decoration: InputDecoration(
                  hintText: "addNoteContentHint".tr(),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              validator: (value) {
                if(value!.length<2){
                  return "addNoteEmptyInput".tr();
                }
                return null;
              },
              onSaved: (newValue) {
                NoteContent=newValue!;
              },  
            ),
            const SizedBox(height: 10,),
            Row(children: [
              Text(
                "addNoteLevelDropdown",
                style: noteUiHelper.noteTitleTextStyle,
              ).tr(),
              const SizedBox(width: 15,),
              Container(
                height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    
                    border: Border.all(width: 2,color: ColorHelper.primarySwatch),
                    borderRadius: BorderRadius.circular(16),
                  ),
                child: DropdownButton(
                  underline: Container(),
                  value: NoteLevel,
                  items: itemsLevel(),
                  onChanged: (value) {
                    setState(() {
                      NoteLevel = value;
                    });
                  },
                ),
              )
            ]),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              ButtonBar(children: [
                OutlinedButton(onPressed: () {
                  Navigator.of(context).pop();
                },
                style: noteUiHelper.DeleteButtonStyle, 
                child: const Text("addNoteGiveupBTN").tr(),
                ),

                OutlinedButton(
                onPressed: () async{
                  if(widget.nt==null){
                    bool validate=formKey.currentState!.validate();
                    if(validate){
                      formKey.currentState!.save();
                      Note newNote=Note.create(title: NoteTitle, content: NoteContent,catagory: NoteCategory,importantLevel: NoteLevel);
                      await database.addnote(newNote);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement( MaterialPageRoute( builder: (context) => const HomePage() ) );
                    }
                  }
                  else{
                    bool validate=formKey.currentState!.validate();
                    if(validate){
                      formKey.currentState!.save();
                      Note newNote=Note.update(nt: widget.nt!,title: NoteTitle, content: NoteContent,catagory: NoteCategory,importantLevel: NoteLevel);
                      await database.addnote(newNote);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement( MaterialPageRoute( builder: (context) => const HomePage() ) );
                    }
                  }
                  
                },
                style: noteUiHelper.updateButtonStyle, 
                child: Text("addNoteSaveBTN",style: noteUiHelper.noteSubtitleTextStyle,).tr(),
                )
                
              ],)
            ],)
          
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> itemsCategoies() {
    Set catagories = database.getAllCategory();
    List<DropdownMenuItem> dropdownItems = catagories
        .map((ctg) => DropdownMenuItem(
              value: ctg,
              child: Text(ctg),
            ))
        .toList();
    return dropdownItems;
  }
  getFirstCategory(){
    return database.getAllCategory().elementAt(0);
  }

  List<DropdownMenuItem> itemsLevel() {
    List<DropdownMenuItem> dropdownItems = [
      DropdownMenuItem(
        value: 1,
        child: const Text("importantLevel1",style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),).tr(),
      ),
      DropdownMenuItem(
        value: 2,
        child: const Text("importantLevel2",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),).tr(),
      ),
      DropdownMenuItem(
        value: 3,
        child: const Text("importantLevel3",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),).tr(),
      ),
    ];
    return dropdownItems;
  }
}
