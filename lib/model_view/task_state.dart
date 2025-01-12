part of 'task_cubit.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class GetDoneTaskLoading extends TaskState{}
final class GetDoneTaskSucsess extends TaskState{}
final class GetDoneTaskError extends TaskState{}


final class GetInProgressTaskLoading extends TaskState{}
final class GetInProgressTaskSucsess extends TaskState{}
final class GetInProgressTaskError extends TaskState{}


final class InitDBLoading extends TaskState{}
final class InitDBSucsess extends TaskState{}
final class InitDBError extends TaskState{}


final class MakeTaskDoneTaskLoading extends TaskState{}
final class MakeTaskDoneTaskSucsess extends TaskState{
  final int id;
  MakeTaskDoneTaskSucsess({required this.id});
}
final class MakeTaskDoneTaskError extends TaskState{}


final class AddTaskModelLoading extends TaskState{}
final class AddTaskModelSucsess extends TaskState{}
final class AddTaskModelError extends TaskState{}


final class EditTaskModelLoading extends TaskState{}
final class EditTaskModelSucsess extends TaskState{}
final class EditTaskModelError extends TaskState{}


final class DeleteTaskModelLoading extends TaskState{}
final class DeleteTaskModelSucsess extends TaskState{
  final int id;
  DeleteTaskModelSucsess({required this.id});
}
final class DeleteTaskModelError extends TaskState{}