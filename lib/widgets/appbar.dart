import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/catagoryPage.dart';
import 'package:flutter_application_9/ui_helpers/notesUiHelper.dart';

// ignore: must_be_immutable
class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();

  @override
 
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarState extends State<Appbar> {
  late String language;

  @override
  Widget build(BuildContext context) {
    context.locale.toString() == "en_US" ? language = "en" : language = "tr";
    return AppBar(
      title: const Text("homeAppbar").tr(),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            List<PopupMenuEntry<dynamic>> popups = [
              PopupMenuItem(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const CatagoryPage(),
                    ));
                  },
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("categoryAppbar").tr(),
                    ],
                  )),
              PopupMenuItem(
                  onTap: () {
                    languageShowDialog(context);
                  },
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language_outlined,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("language").tr(),
                    ],
                  ))
            ];
            return popups;
          },
        )
      ],
    );
  }

  Future<dynamic> languageShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(16),
          title: Row(
            children: [
              const Icon(
                Icons.language_outlined,
                color: Colors.orange,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "language",
                style: noteUiHelper.noteTitleTextStyle,
              ).tr(),
            ],
          ),
          children: [
            const Divider(
              color: Colors.purple,
            ),
            const SizedBox(
              height: 10,
            ),
            const Icon(
              Icons.language_outlined,
              color: Colors.orange,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("English-EN"), Text("Türkçe-TR")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Radio(
                  value: "en",
                  groupValue: language,
                  onChanged: (value) {
                    if (language != value) {
                      setState(() {
                        language = value!;
                        context.setLocale(const Locale('en', "US"));
                        
                      });
                    }
                  },
                ),
                Radio(
                  value: "tr",
                  groupValue: language,
                  onChanged: (value) {
                    if (language != value) {
                      setState(() {
                        language = value!;
                        context.setLocale(const Locale('tr', "TR"));
                        
                      });
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 10,),
            Text("languageChangewarning",style: noteUiHelper.contentTextStyle,).tr()
          ],
        );
      },
    );
  }
}
