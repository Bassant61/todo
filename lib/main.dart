import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/view/screens/intro/on_boarding.dart';
import 'package:todo/view/screens/intro/todo_splash.dart';
import 'core/chah_helper/block_observer.dart';
import 'core/chah_helper/chach_helper.dart';
import 'core/chah_helper/localdbhelper.dart';
import 'model_view/task_cubit.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initSharedPref();
  runApp(my_App());
}
class my_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskCubit()..initdb(),
          ),
        ],
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            var cubit = TaskCubit.get(context);
            return MaterialApp(
              home: OnboardingScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}

class _tstlocalDatabasState extends StatefulWidget {
  const _tstlocalDatabasState({super.key});

  @override
  State<_tstlocalDatabasState> createState() => __tstlocalDatabasStateState();
}

class __tstlocalDatabasStateState extends State<_tstlocalDatabasState> {
  late Database database;
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  init() async {
    await localDatabaseHelper.initDatabase(databasePathName: "mydb");
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await localDatabaseHelper.insertToDatabase(
                    values: {"di": 1, "name": "Bassant"}, tableName: "task");
              },
              child: const Text('Add to database'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('Update database'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('Delete from database'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print(await localDatabaseHelper.retrieveData(
                    tableName: "task", where: ''));
              },
              child: const Text('Get from the database then print'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await localDatabaseHelper.execute(
                    query:
                    "CREATE TABLE task(id INTEGER PRIMARY KEY,name TEXT)");
              },
              child: const Text('Add tasks table'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}