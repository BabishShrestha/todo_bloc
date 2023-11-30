import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/core/models/task_model.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/xpansion_cubit.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';
import 'package:todo_riverpod/features/todo/widgets/update_task.dart';

import '../../../core/utils/constants.dart';
import 'custom_expansion_tile.dart';

class TomorrowList extends StatelessWidget {
  const TomorrowList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    final xpansionCubit = BlocProvider.of<XpansionCubit>(context);

    return SizedBox(
      width: AppConst.kWidth,
      child: BlocBuilder<TodoCubit, List<Task>>(builder: (context, todoState) {
        final todos = todoState;
        final getTomorrowDate = todoCubit.getTomorrow();
        final tomorrowTodos = todos.where((todo) {
          return todo.date!.contains(getTomorrowDate);
        }).toList();
        return BlocBuilder<XpansionCubit, bool>(
            builder: (context, xpansionState) {
          return CustomExpansionTile(
              title: "Tomorrow's Task",
              subtitle: "Tomorrow's Task are shown below",
              onExpansionChanged: (expand) {
                xpansionCubit.setState(expand);
              },
              trailing: xpansionState
                  ? const Icon(
                      AntDesign.closecircleo,
                      color: AppConst.kBlueLight,
                    )
                  : const Icon(
                      AntDesign.circledown,
                      color: AppConst.kLight,
                    ),
              children: [
                for (final task in tomorrowTodos)
                  TodoTile(
                    switcher: const SizedBox.shrink(),
                    onTapDelete: () {
                      todoCubit.deleteItem(task.id ?? 0);
                    },
                    editWidget: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateTask(task: task)));
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
                    // switcher: Switch(
                    //   activeColor: AppConst.kLight,
                    //   activeTrackColor: AppConst.kGreen,
                    //   onChanged: (bool value) {
                    //     isCompleted = value;
                    //   },
                    //   value: isCompleted,
                    // ),
                  ),

                // ListView.builder(
                //   itemCount: tomorrowTodos.length,
                //   itemBuilder: (context, index) {

                //     // dev.log(isCompleted.toString());
                //     return  },
                // ),

                // TodoTile(
                //   start: '9:00',
                //   end: '11:00',
                //   // switcher: Switch(
                //   //   activeColor: AppConst.kLight,
                //   //   activeTrackColor: AppConst.kGreen,
                //   //   onChanged: (bool value) {
                //   //     // ref.read(toggleSwitch.notifier).state = value;
                //   //   },
                //   //   value: ref.watch(toggleSwitch),
                //   // ),
                // ),
              ]);
        });
      }),
    );
  }
}
