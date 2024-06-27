import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sq_flite/db/functions/functions.dart';
import 'package:sq_flite/db/model/model.dart';
import 'package:sq_flite/screens/Details_Screen.dart';
import 'package:sq_flite/screens/edit_student.dart';


class ListStudentwid extends StatelessWidget {
  const ListStudentwid({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext ctx, List<StudentModel> studentList, Widget? child){
        return ListView.separated(itemBuilder:(ctx,index){
          final data= studentList[index]; 
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DataScreen(data: data),));
          },
          title: Text(data.name),
          subtitle: Text(data.age),
          leading:CircleAvatar(backgroundImage:FileImage(File(data.image))) ,
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> EditStudent(data: data,)) );
                }, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){
                  if(data.id!=null){
                  deleteStudent(data.id!);
                  }
                }, 
                icon: const Icon(Icons.delete),
                color: Colors.red,),
              ],
            ),
          )
        );
      }, 
      separatorBuilder: (context, index) {
        return const Divider();
      }, 
      itemCount: studentList.length,
        );
      },
      
    );
  }
}