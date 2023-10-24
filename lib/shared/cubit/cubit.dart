import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:flutter_udemy/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:flutter_udemy/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:flutter_udemy/shared/cubit/states.dart';
import 'package:flutter_udemy/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarStates());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() async {
    return openDatabase('todo.db', version: 1, onCreate: (database, version) {
      // id integer
      // title String
      // time String
      // date String
      // status String
      print('database created');
      database
          .execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT, time TEXT, date TEXT, status TEXT)',
      )
          .then((value) {
        print('table created ');
      }).catchError((error) {
        print('Error When Creating Table  ${error.toString()}');
      });
    }, onOpen: (database) {
      getDateFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseStates());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value insert successfully ');
        emit(AppInsertDatabaseStates());

        getDateFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDateFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingStates());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseStates());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDateFromDatabase(database);
      emit(AppUpdateDatabaseStates());
    });
  }

  void deleteDate({
    required int id,
  }) async {
    database.rawDelete(
      'DELETE FROM tasks  WHERE id = ?',
      [id],
    ).then((value) {
      getDateFromDatabase(database);
      emit(AppDeleteDatabaseStates());
    });
  }

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetStates({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetStates());
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.getData(
        key: 'isDark',
      ).then((value) {
        emit(AppChangeModeStates());
      });
    }
  }
}
