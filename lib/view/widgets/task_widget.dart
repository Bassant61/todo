import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
import 'package:todo/view/widgets/task_action_widget.dart';
import '../../model/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, this.delete, this.edit, required this.taskmodel, this.Done});
  final Taskmodel taskmodel;
  final void Function()?delete;
  final void Function()?edit;
  final void Function()? Done;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
      ),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4.68,
                offset: Offset.zero
            ),
          ]
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskmodel.title??'No title',
                    style:const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    Jiffy.parse(taskmodel.datetime.toString()).yMMMMEEEEdjm,
                    style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2
                    ),
                    decoration: BoxDecoration(
                      color:Color(0xffFCEEF5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      taskmodel.level??'Low',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              )
          ),
          taskmodel.isDone == true? Icon(Icons.task_alt,color: Colors.green):Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  actionbotton(iconpath: 'assets/svg/edit.svg', onPressed: edit),
                  SizedBox(
                    width: 8,
                  ),
                  actionbotton(iconpath: 'assets/svg/delete.svg', onPressed: delete)
                ],
              ),
              SizedBox(
                height: 20,
                child: TextButton(
                    style:TextButton.styleFrom(
                        padding: EdgeInsets.zero
                    ),
                    onPressed: Done,
                    child: Text('Done',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'inter',
                          color: Color(0xffE53170)
                      ),
                    )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
