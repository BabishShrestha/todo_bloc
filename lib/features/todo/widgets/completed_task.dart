import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../core/models/task_model.dart';
import '../../../core/utils/constants.dart';

class CompletedTaskList extends ConsumerWidget {
  const CompletedTaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final getLast30DaysDate =
        ref.read(todoStateProvider.notifier).getLast30Days();
    final completedTodos = todos
        .where((todo) =>
            todo.isCompleted == 1 ||
            getLast30DaysDate.contains(todo.date!.substring(0, 10)))
        .toList();
    completedTodos.sort((a, b) => b.startTime!.compareTo(a.startTime!));

    return Container(
      height: AppConst.kHeight * 0.3,
      decoration: BoxDecoration(
        color: AppConst.kBkDark,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConst.kRadius),
        ),
      ),
      child: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (BuildContext context, int index) {
          final Task task = completedTodos[index];

          return TodoTile(
              onTapDelete: () {
                ref.read(todoStateProvider.notifier).deleteItem(task.id ?? 0);
              },
              editWidget: const SizedBox.shrink(),
              title: task.title ?? 'a',
              description: task.desc ?? 'desc',
              color: ref.watch(todoStateProvider.notifier).getRandomColor(),
              start: task.startTime ?? '1010',
              end: task.endTime ?? '1010',
              switcher: const Icon(
                AntDesign.checkcircle,
                color: AppConst.kGreen,
              ));
        },
      ),
    );
  }
}
