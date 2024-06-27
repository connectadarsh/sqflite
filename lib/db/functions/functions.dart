import 'dart:async';
import 'package:flutter/material.dart';

import 'package:sq_flite/db/model/model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>>studentListNotifier=ValueNotifier([]);

 late Database _db;

Future<void>initialDatabase()async{
_db=await openDatabase('student.db',version:1,
onCreate:(Database db, int version)async{
  await db.execute('CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT,age TEXT,image TEXT,mobile TEXT)');
},
);
}

Future<void> addStudent(StudentModel value)async{
  await _db.rawInsert('INSERT INTO student(name,age,image,mobile) VALUES(?,?,?,?)',[value.name,value.age,value.image,value.mobile]);
  studentListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();

}

Future<void> getAllStudents()async{
  //  final studentDB= await Hive.openBox<StudentModel>('student_db');
   
   final values =await _db.rawQuery('SELECT *FROM student');
   studentListNotifier.value.clear();
   for (var map in values) {
    final student=StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
   studentListNotifier.notifyListeners();
   }

}

Future<void>deleteStudent(int id)async{
_db.rawDelete('DELETE FROM student WHERE id = ?',[id]);
 getAllStudents();
}


Future<void> searchStudent(String value) async {
  final students = await _db.query(
    'student',
    where: 'LOWER(name) LIKE ?',
    whereArgs: ['%${value.toLowerCase()}%'],
  );
  studentListNotifier.value =
      students.map((element) => StudentModel.fromMap(element)).toList();
}



Future<void> updateStudent(StudentModel value) async {
  await _db.rawUpdate(
    'UPDATE student SET name = ?,age = ?,image = ?,mobile = ? WHERE id = ?',
    [
      value.name,
      value.age,
      value.image,
      value.mobile,
      value.id
    ],
  );
  
  await getAllStudents();
}


