


// ignore_for_file: file_names

import 'package:flutter_application_9/models/note.dart';
import 'package:hive/hive.dart';

class HiveDatabase{
  late Box<Note> noteBox;
  late Box<String> categoryBox;
  HiveDatabase(){
    noteBox=Hive.box("notes");
    categoryBox=Hive.box("categories");
  }

  Future<void> addnote(Note nt)async{
    await noteBox.put(nt.id,nt);
  }
  List<Note> getAllNotes(){
    List<Note> notes=[];
    if(noteBox.isNotEmpty){
      notes=noteBox.values.toList();
      notes.sort((a, b) => a.importantLevel.compareTo(b.importantLevel),);
      notes=notes.reversed.toList();
    }
    return notes;
  }
  Future<void> putNote(Note nt)async{
    await noteBox.put(nt.id, nt);
  }

  Future<void> deleteNote(Note nt)async{
    await noteBox.delete(nt.id);
  }



  Set getAllCategory(){
    Set notes=<String>{};
    if(categoryBox.isNotEmpty){
      notes= categoryBox.values.toSet();
    }
    return notes;
  }
  Future<void> deleteCategory(ctg)async{
    await categoryBox.delete(ctg);
    List<Note> notes=getAllNotes();
    for (var nt in notes) {
      if(nt.catagory==ctg){
        await deleteNote(nt);
      }
    }
  }
  Future<void> addCategory(String ctg)async{
    ctg=ctg.replaceRange(0, 1, ctg[0].toUpperCase());
    if(categoryBox.isNotEmpty){
      if(!categoryBox.keys.contains(ctg)){
        await categoryBox.put(ctg, ctg);
      }
    }
    else{
      await categoryBox.put(ctg, ctg);
    }
  }

  bool categoryIsEmpty(){
    return categoryBox.isEmpty;
  }
}