import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM{
  static const String CollectionName="todo";
 late String title;
  late String descreption;
 late String id;
  late DateTime date;
  late bool ischecked=false;

  TodoDM({required this.title,required this.date,required this.descreption,required this.id,required this.ischecked});

  TodoDM.fromjson(Map<String,dynamic> json){
    id=json["id"];
    title=json["title"];
    descreption=json["descreption"];
    Timestamp timestamp=json["date"];
    date=timestamp.toDate();

    ischecked=json["ischecked"];
  }

  Map<String,dynamic> Tojson() => {
    "id":id,
    "title":title,
    "descreption":descreption,
    "date":date,
    "ischecked":ischecked
  };

}