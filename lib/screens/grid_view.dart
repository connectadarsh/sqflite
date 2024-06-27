import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sq_flite/db/functions/functions.dart';
import 'package:sq_flite/db/model/model.dart';
import 'package:sq_flite/screens/Details_Screen.dart';
import 'package:sq_flite/screens/edit_student.dart';

class GridStudentWid extends StatelessWidget {
  const GridStudentWid({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final data = studentList[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DataScreen(data: data)));
                },
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                        radius: 40,
                      ),
                      Text(data.name),
                      Text(data.mobile),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditStudent(data: data)));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                if (data.id != null) {
                                  deleteStudent(data.id!);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
