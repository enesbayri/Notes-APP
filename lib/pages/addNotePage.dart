// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/widgets/addNoteForm.dart';

// ignore: must_be_immutable
class AddNotePage extends StatelessWidget {
  Note? nt=Note.create(title: "", content: "");
  AddNotePage({Note? note,super.key}){
    nt=note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(title: const Text("addNoteAppbar").tr()),
      body: Container(
        child:nt==null?AddNoteForm():AddNoteForm(note: nt),
        ),
    );
  }
}