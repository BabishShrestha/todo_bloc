import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';
import 'package:todo_riverpod/features/todo/widgets/update_task.dart';

import '../../../core/models/task_model.dart';
import '../../../core/utils/constants.dart';

class TodayTask extends StatelessWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);

    return Container(
      height: AppConst.kHeight * 0.3,
      decoration: BoxDecoration(
        color: AppConst.kBkDark,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConst.kRadius),
        ),
      ),
      child: BlocBuilder<TodoCubit, List<Task>>(
        builder: (context, state) {
          List<Task> taskList = state;
          String todayTask = todoCubit.getToday();
          final todayTaskList = taskList
              .where((task) =>
                  task.isCompleted == 0 && task.date!.contains(todayTask))
              .toList();
          todayTaskList.sort((a, b) => b.startTime!.compareTo(a.startTime!));

          return ListView.builder(
              itemCount: todayTaskList.length,
              itemBuilder: (context, index) {
                final Task task = todayTaskList[index];
                bool isCompleted = todoCubit.getStatus(task);
                dev.log(isCompleted.toString());

                return TodoTile(
                  onTapDelete: () {
                    todoCubit.deleteItem(task.id ?? 0);
                  },
                  editWidget: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateTask(task: task)));

                      // ref.read(todoStateProvider.notifier).updateItem(task);
                    },
                    icon: const Icon(
                      MaterialCommunityIcons.circle_edit_outline,
                      color: AppConst.kLight,
                    ),
                  ),
                  title: task.title ?? 'a',
                  description: task.desc ?? 'desc',
                  color: todoCubit.getRandomColor(),
                  start: task.startTime ?? '1010',
                  end: task.endTime ?? '1010',
                  switcher: Switch(
                    inactiveTrackColor: AppConst.kBkDark,
                    // activeColor: AppConst.kGreen,
                    // activeTrackColor: AppConst.kGreen,
                    onChanged: (bool value) {
                      todoCubit.markAsCompleted(task);
                      // isCompleted = value;
                    },
                    value: isCompleted,
                  ),
                );
              });
        },
      ),

      // ListView(
      //   children: [
      //     TodoTile(
      //       start: '9:00',
      //       end: '11:00',
      //       switcher: Switch(
      //         activeColor: AppConst.kLight,
      //         activeTrackColor: AppConst.kGreen,
      //         onChanged: (bool value) {
      //           ref.read(toggleSwitch.notifier).state =
      //               value;
      //         },
      //         value: ref.watch(toggleSwitch),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
