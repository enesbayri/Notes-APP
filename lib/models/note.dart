
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String catagory;
  @HiveField(3)
  late String content;
  @HiveField(4)
  late int importantLevel;
  @HiveField(5)
  late DateTime createdAt;

  Note({required this.id,required this.title,required this.content,required this.catagory,required this.importantLevel,required this.createdAt});

  factory Note.create({required title,required content,catagory="Genel",importantLevel=3}){
    DateTime now=DateTime.now();
    return Note(id: const Uuid().v1(), title: title, content: content, createdAt: now,catagory: catagory,importantLevel: importantLevel);
  }

  factory Note.update({required Note nt,required title,required content,catagory="Genel",importantLevel=3}){
    DateTime now=DateTime.now();
    return Note(id:nt.id, title: title, content: content, createdAt: now,catagory: catagory,importantLevel: importantLevel);
  }
}