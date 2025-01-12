import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../model_view/task_cubit.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../widgets/edit_task_bottom_sheet.dart';
import '../widgets/task_widget.dart';

class InProgressTask extends StatefulWidget {
  const InProgressTask({super.key});

  @override
  State<InProgressTask> createState() => _InProgressTaskState();
}

class _InProgressTaskState extends State<InProgressTask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskCubit.get(context).getinprogresstasklist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'In Progress Tasks',
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if(state is MakeTaskDoneTaskSucsess){
            TaskCubit.get(context).InProgressTasklist.removeWhere((element){
              print(element.Taskid == state.id);
              return element.Taskid == state.id;
            }
            );
          }
          else if(state is DeleteTaskModelSucsess){
            TaskCubit.get(context).InProgressTasklist.removeWhere((element){
              return element.Taskid == state.id;
            }
            );
          }
        },
        builder: (context, state) {
          return state is GetInProgressTaskLoading?Center(child: CircularProgressIndicator(),):
          TaskCubit.get(context).InProgressTasklist.isNotEmpty? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              itemBuilder: (context, index) {
                return TaskWidget(
                    taskmodel: TaskCubit.get(context).InProgressTasklist[index],
                    delete: () {
                      final taskId = TaskCubit.get(context).InProgressTasklist[index].Taskid ?? 0;
                      TaskCubit.get(context).deleteTask(taskid: taskId);
                    },
                    edit: () {
                      showModalBottomSheet(context: context, builder: (context){
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: EditTaskBottomsheet(taskmodel: TaskCubit.get(context).InProgressTasklist[index],),
                        );
                      });
                    } ,
                    Done: (){TaskCubit.get(context).add_task_done(
                        taskid: TaskCubit.get(context).InProgressTasklist[index].Taskid??0);});
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: TaskCubit.get(context).InProgressTasklist.length):Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43),
              child: Center(
                  child: Lottie.asset(
                      "assets/lotties/empty.json")),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffE53170),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddTaskBottomSheet());
              }).whenComplete(() {
          });
        },
        child: SvgPicture.asset(
          "assets/svg/add.svg",
          height: 35,
          width: 35,
        ),
      ),
    );
  }
}

enum levelenum { High, Medium, Low }
