import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../core/models/task_model.dart';
import '../../../core/utils/constants.dart';

class CompletedTaskList extends StatelessWidget {
  const CompletedTaskList({
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
      child: BlocBuilder<TodoCubit, List<Task>>(builder: (context, todoState) {
        final todos = todoState;
        final getLast30DaysDate = todoCubit.getLast30Days();
        final completedTodos = todos
            .where((todo) =>
                todo.isCompleted == 1 ||
                getLast30DaysDate.contains(todo.date!.substring(0, 10)))
            .toList();
        completedTodos.sort((a, b) => b.date!.compareTo(a.date!));
        return ListView.builder(
          itemCount: completedTodos.length,
          itemBuilder: (BuildContext context, int index) {
            final Task task = completedTodos[index];

            return TodoTile(
                onTapDelete: () {
                  todoCubit.deleteItem(task.id ?? 0);
                },
                editWidget: const SizedBox.shrink(),
                title: task.title ?? 'a',
                description: task.desc ?? 'desc',
                color: todoCubit.getRandomColor(),
                start: task.startTime ?? '1010',
                end: task.endTime ?? '1010',
                switcher: const Icon(
                  AntDesign.checkcircle,
                  color: AppConst.kGreen,
                ));
          },
        );
      }),
    );
  }
}
