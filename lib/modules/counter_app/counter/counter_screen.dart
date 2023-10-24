import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, states) {
          if (states is CounterMinusStats) {
            // print('minus states ${states.counter}');
          }
          if (states is CounterPlusStats) {
            // print('plus states ${states.counter}');
          }
          if (states is CounterRestoreIconStats) {
            // print('restore states ${states.counter}');
          }
        },
        builder: (context, states) {
          var cubit = CounterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      cubit.mines();
                    },
                    child: Text(
                      'MINUS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${cubit.counter}',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.plus();
                    },
                    child: Text(
                      'PLUS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.restoreIcon();
              },
              child: Icon(
                Icons.settings_backup_restore,
              ),
            ),
          );
        },
      ),
    );
  }
}
