import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'done_task.dart';
import 'inprogress_task.dart';



class Noteapp extends StatefulWidget {
  const Noteapp({super.key});

  @override
  State<Noteapp> createState() => _NoteappState();
}

class _NoteappState extends State<Noteapp> {
  List<Widget>screenslist=[
    InProgressTask(),
    DoneTasks()
  ];
  int curr = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screenslist[curr],
        bottomNavigationBar:BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xffE53170),
          currentIndex: curr,
          onTap: (index){
            curr = index;
            setState(() {
            });
          },
          items:[
            BottomNavigationBarItem(
                icon:Icon(
                    Icons.today),
                label: 'In Progress Tasks'
            ),
            BottomNavigationBarItem(
                icon:Icon(
                    Icons.task_alt),
                label: 'Done Tasks'
            ),
          ],
        ),
      ),
    );
  }
}