import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/chah_helper/localdbhelper.dart';
import '../model/task_model.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  static TaskCubit get(Context){
    return BlocProvider.of(Context);
  }
  TaskCubit() : super(TaskInitial());
  List<Taskmodel> donetasklist = [];
  List<Taskmodel> InProgressTasklist = [];

  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  void initdb() async {
    emit(InitDBLoading());
    try {
      await localDatabaseHelper.initDatabase(
          databasePathName: 'task_app',
          onCreate: (database, version) async {
            await database.execute(
                "CREATE TABLE task(id INTEGER PRIMARY KEY, title TEXT, isDone INTEGER, datetime TEXT, level TEXT)"
            );
          }
      );
      emit(InitDBSucsess());
    } catch (error) {
      emit(InitDBError());
    }
  }
  Future <void> getDonetasklist()async{
    donetasklist.clear();
    emit(GetDoneTaskLoading());
    try{
      final List<Map<String,dynamic>> list = await localDatabaseHelper.retrieveData(
          tableName: 'task',
          where: "isDone = 1"
      );
      for (var element in list) {
        donetasklist.add(Taskmodel.fromMap(element));
      }
      emit(GetDoneTaskSucsess());
    }
    catch(error){
      emit(GetDoneTaskError());
    }
  }

  Future <void> getinprogresstasklist()async{
    InProgressTasklist.clear();
    emit(GetInProgressTaskLoading());
    try{
      final List<Map<String,dynamic>> list = await localDatabaseHelper.retrieveData(
          tableName: 'task',
          where: "isDone = 0"
      );
      print(list);
      for (var element in list) {
        InProgressTasklist.add(Taskmodel.fromMap(element));
      }
      emit(GetInProgressTaskSucsess());
    }
    catch(error){
      emit(GetInProgressTaskError());
    }
  }
  Future <void> add_task_done({required int taskid})async{
    emit(MakeTaskDoneTaskLoading());
    try{
      await localDatabaseHelper.updateDatabase(
          values: {"isDone": 1},
          query: "id = $taskid",
          tableName: "task");

      emit(MakeTaskDoneTaskSucsess(id: taskid));
    }
    catch(error){
      emit(MakeTaskDoneTaskError());
    }
  }
  void addNewTask({required Taskmodel Taskmodel})async{
    emit(AddTaskModelLoading());
    try{
      await localDatabaseHelper.insertToDatabase(values: Taskmodel.toMap(), tableName: "task");
      emit(AddTaskModelSucsess());
    }
    catch(error){
      emit(AddTaskModelError());
    }
  }
  Future<void>editTask({required Taskmodel Taskmodel})async{
    emit(EditTaskModelLoading());
    try{
      await localDatabaseHelper.updateDatabase(values: Taskmodel.toMap(),
          tableName: "task", query: "id = ${Taskmodel.Taskid}");
      emit(EditTaskModelSucsess());
    }
    catch(error){
      emit(EditTaskModelError());
    }
  }
  void deleteTask({required int taskid})async{
    emit(DeleteTaskModelLoading());
    try{
      await localDatabaseHelper.deleteDatabase(
          tableName: "task",
          query: "id = $taskid"
      );
      emit(DeleteTaskModelSucsess(id: taskid));
    }
    catch(error){
      emit(DeleteTaskModelError());
    }
  }
}
