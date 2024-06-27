import 'package:flutter/material.dart';
import 'package:sq_flite/db/functions/functions.dart';
import 'package:sq_flite/screens/add_student.dart';
import 'package:sq_flite/screens/grid_view.dart';
import 'package:sq_flite/screens/list_student.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=TextEditingController();
    
    getAllStudents();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white54,
          centerTitle: true,
          title: const Text('Student Data',),
        ),
        body:  SafeArea(
          child:Column(
            children: [
              Padding(
                padding:  const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    searchStudent(value);
                  },
                  decoration: InputDecoration(
                      hintText: 'search',
                      suffixIcon: IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.search)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),

            const TabBar(tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.grid_view),)
            ]),
            const Expanded(
              child: TabBarView(children: [
                Center(
                  child:ListStudentwid(),
                ),
                Center(
                  child:GridStudentWid(),
                )
              ]
              
              ),
            )
              
            ],
          )
        ),
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add,
        color: Colors.white54,),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => const AddStudent(),
          ));
      }
      ) ,
      ),
    );
  }
}