import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../core/chah_helper/localdbhelper.dart';
import '../../model/task_model.dart';
import '../../model_view/task_cubit.dart';
import '../screens/inprogress_task.dart';

class EditTaskBottomsheet extends StatefulWidget {
  final Taskmodel taskmodel;
  const EditTaskBottomsheet({super.key, required this.taskmodel});

  @override
  State<EditTaskBottomsheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<EditTaskBottomsheet> {
  void iniResources(){
    controller = TextEditingController(text:widget.taskmodel.title);
    value = tasklevel.firstWhere((element){
      return element.name == widget.taskmodel.level;
    });
    datetime = widget.taskmodel.datetime;
  }
  @override
  void initState(){
    super.initState();
    iniResources();
  }
  List<levelenum> tasklevel = [levelenum.High, levelenum.Medium, levelenum.Low];
  levelenum? value;
  String? datetime;
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if(state is EditTaskModelSucsess){
            Navigator.pop(context);
            TaskCubit.get(context).getinprogresstasklist();
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffE53170)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Task Level',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffE53170)),
                  ),
                ),
                items: tasklevel
                    .map((level) => DropdownMenuItem(
                  child: Text(
                    level.name,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  value: level,
                ))
                    .toList(),
                value: value,
                onChanged: (level) {
                  setState(() {
                    value = level;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xffE53170), // Header background color
                            onPrimary: Colors.white, // Header text color
                            onSurface: Colors.black, // Body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xffE53170), // Button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((date) {
                    if (date != null) {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xffE53170), // Header background color
                                onPrimary: Colors.white, // Header text color
                                onSurface: Colors.black, // Body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(0xffE53170), // Button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((time) {
                        if (time != null) {
                          setState(() {
                            datetime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            ).toString();
                          });
                        } else {
                          setState(() {
                            datetime = null;
                          });
                        }
                      });
                    }
                  }).catchError((error) {
                    print(
                        'Error: $error (Could not read date time of input, try using a valid pattern)');
                  });
                },
                child: Text(
                  datetime != null
                      ? Jiffy.parse(datetime!).yMMMMEEEEdjm
                      : "Select Date",
                  style: TextStyle(
                    color: Color(0xffE53170),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    TaskCubit.get(context).editTask(Taskmodel: Taskmodel(
                        Taskid: widget.taskmodel.Taskid,
                        isDone: widget.taskmodel.isDone,
                        datetime:datetime,
                        level:value?.name,
                        title: controller.text
                    ));
                  },
                  child: state is EditTaskModelLoading?Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  ),):Text(
                    'Edit Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color((0xffE53170)),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height:2),
            ],
          );
        },
      ),
    );
  }
}
