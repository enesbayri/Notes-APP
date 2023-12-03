// ignore_for_file: file_names, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/HiveDatabase.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/pages/addNotePage.dart';
import 'package:flutter_application_9/ui_helpers/notesUiHelper.dart';

class NoteList extends StatefulWidget {
  
  const NoteList({
    super.key,
  });

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  HiveDatabase database =HiveDatabase();
  late List<Note> notes;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    notes=database.getAllNotes();
    return notes.isEmpty? EmptyNoteList(): NoteList();
  }

  Center EmptyNoteList() => Center(child: Text("homeEmptyList",style: noteUiHelper.emptyListTextStyle,).tr(),);

  Container NoteList() {
    return Container(
    child: ListView.builder(
        itemBuilder: (context, index) {
          Note nt = notes[index];
          return ExpansionTile(
            leading: noteUiHelper.levelCircleAvatar(nt.importantLevel),
            title: Text(
              nt.title,
              style: noteUiHelper.noteTitleTextStyle,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "homeExpantionTileCategory".tr(),
                          style: noteUiHelper.noteTitleTextStyle,
                        ),
                        Text(
                          nt.catagory,
                          style: noteUiHelper.noteSubtitleTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "homeExpantionTileCreated".tr(),
                          style: noteUiHelper.noteTitleTextStyle,
                        ),
                        Text(
                          noteUiHelper.noteDate(nt),
                          style: noteUiHelper.noteSubtitleTextStyle,
                        )
                      ],
                    ),
                    Text(
                      "homeExpantionTileContentTitle".tr(),
                      style: noteUiHelper.noteTitleTextStyle,
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Colors.purple,
                    ),
                    Text(nt.content,style: noteUiHelper.contentTextStyle,),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Colors.purple,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonBar(
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    database.deleteNote(nt);
                                  });
                                },
                                style: noteUiHelper.DeleteButtonStyle,
                                child: const Text("homeExpantionDeleteBTN").tr()),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNotePage(note: nt),));
                                },
                                style: noteUiHelper.updateButtonStyle,
                                child: Text(
                                  "homeExpantionUpdateBtn",
                                  style: noteUiHelper.noteSubtitleTextStyle,
                                ).tr()),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
        itemCount: notes.length),
  );
  }
}
