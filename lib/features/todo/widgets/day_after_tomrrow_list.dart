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

class DayAfterTomorrowList extends StatelessWidget {
  const DayAfterTomorrowList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    final xpansionCubit0 = BlocProvider.of<XpansionCubit0>(context);

    return SizedBox(
      width: AppConst.kWidth,
      child: BlocBuilder<TodoCubit, List<Task>>(builder: (context, todoState) {
        final todos = todoState;
        final getDayAfterTomorrowDate = todoCubit.getDayAfterTomorrow();
        final dayAfterTomorrowTodos = todos.where((todo) {
          return todo.date!.contains(getDayAfterTomorrowDate);
        }).toList();

        return BlocBuilder<XpansionCubit0, bool>(
            builder: (context, xpansionState) {
          return CustomExpansionTile(
              title: getDayAfterTomorrowDate.substring(5, 10) //get date
              ,
              subtitle: "Day After Tomorrow's Task are shown below",
              onExpansionChanged: (expand) {
                xpansionCubit0.setState(expand);
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
                for (final task in dayAfterTomorrowTodos)
                  TodoTile(
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
                    switcher: const SizedBox.shrink(),
                  ),
              ]);
        });
      }),
    );
  }
}
