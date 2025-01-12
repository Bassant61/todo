import 'package:flutter/material.dart'; // For Flutter UI
import 'package:flutter_bloc/flutter_bloc.dart'; // For BlocConsumer
import 'package:lottie/lottie.dart'; // For Lottie animations
import '../../model_view/task_cubit.dart'; // Your TaskCubit implementation
import '../widgets/task_widget.dart'; // Custom TaskWidget

class DoneTasks extends StatefulWidget {
  const DoneTasks({super.key});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskCubit.get(context).getDonetasklist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Done Tasks',
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

          },
          builder: (context, state) {
            return state is GetDoneTaskLoading?Center(child: CircularProgressIndicator(),):
            TaskCubit.get(context).donetasklist.isNotEmpty? ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                itemBuilder: (context, index) {
                  return TaskWidget(
                      taskmodel:
                      TaskCubit.get(context).donetasklist[index],
                      delete: () {},
                      edit: () {});
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount:
                TaskCubit.get(context).donetasklist.length):Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43),
                child: Center(
                    child: Lottie.asset(
                        "assets/lotties/emptylottie.json")),
              ),
            );
          },
        ));
  }
}
