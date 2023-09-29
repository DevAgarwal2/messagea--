import "package:cloud_firestore/cloud_firestore.dart";
String formatData(Timestamp timestamp){
  DateTime dateTime = DateTime.now();
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String formatCode = "$day/$month/$year";
   return formatCode;
}