// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:google_fonts/google_fonts.dart';

class noteUiHelper {
  static levelCircleAvatar(level) {
    if (level == 1) {
      return CircleAvatar(
        backgroundColor: Colors.purple.shade100,
        child: const Text(
          "importantLevel1",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
        ).tr(),
      );
    } else if (level == 2) {
      return CircleAvatar(
        backgroundColor: Colors.purple.shade100,
        child: const Text(
          "importantLevel2",
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
        ).tr(),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.purple.shade100,
        child: const Text(
          "importantLevel3",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
        ).tr(),
      );
    }
  }
  static TextStyle emptyListTextStyle = const TextStyle(fontWeight: FontWeight.bold,color: Colors.purple,fontSize:24 );
  static TextStyle noteTitleTextStyle = const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle contentTextStyle = GoogleFonts.signika(color: Colors.grey.shade700);
   static TextStyle categoryDeleteTextStyle = const TextStyle(fontWeight: FontWeight.bold,color: Colors.red);

  static noteDate(Note nt) {
    return nt.createdAt.day == DateTime.now().day
        ? "homeExpantionTileCreatedToday".tr()
        : ((nt.createdAt.day == DateTime.now().day - 1)
            ? "homeExpantionTileCreatedYesterDay".tr()
            : DateFormat('yyyy-MM-dd – kk:mm').format(nt.createdAt));
  }

  static TextStyle noteSubtitleTextStyle =
      const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange);
  static ButtonStyle updateButtonStyle = ButtonStyle(
      side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(color: Colors.orange)));
  static ButtonStyle DeleteButtonStyle = ButtonStyle(
      side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(color: Colors.purple)));

  static ButtonStyle DeleteCategoryButtonStyle = ButtonStyle(
      side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(color: Colors.red))); 

  static TextStyle deleteCategoryTextStyle = GoogleFonts.signika(color: Colors.grey.shade900,fontWeight: FontWeight.bold);               
}
