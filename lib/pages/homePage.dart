
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_9/widgets/appbar.dart';
import 'package:flutter_application_9/widgets/floatingActionButtons.dart';
import 'package:flutter_application_9/widgets/noteList.dart';


// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Appbar(),
      body: const NoteList(),
      floatingActionButton: FloatingActionButtons(),
    );
  }
}
