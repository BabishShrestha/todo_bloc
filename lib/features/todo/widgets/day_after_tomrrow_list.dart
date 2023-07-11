import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';
import 'package:todo_riverpod/features/todo/widgets/update_task.dart';

import '../../../core/utils/constants.dart';
import '../controllers/xpansion_provider.dart';
import 'custom_expansion_tile.dart';

class DayAfterTomorrowList extends ConsumerWidget {
  const DayAfterTomorrowList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final getDayAfterTomorrowDate =
        ref.read(todoStateProvider.notifier).getDayAfterTomorrow();
    final dayAfterTomorrowTodos = todos.where((todo) {
      return todo.date!.contains(getDayAfterTomorrowDate);
    }).toList();

    return SizedBox(
      width: AppConst.kWidth,
      child: CustomExpansionTile(
          title: getDayAfterTomorrowDate.substring(5, 10) //get date
          ,
          subtitle: "Day After Tomorrow's Task are shown below",
          onExpansionChanged: (expand) {
            ref.read(xpansionState0Provider.notifier).setState(expand);
          },
          trailing: ref.watch(xpansionState0Provider)
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
                  ref.read(todoStateProvider.notifier).deleteItem(task.id ?? 0);
                },
                editWidget: IconButton(
                  onPressed: () {  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTask(task: task )));
                  },
                  icon: const Icon(
                    MaterialCommunityIcons.circle_edit_outline,
                    color: AppConst.kLight,
                  ),
                ),
                title: task.title ?? 'a',
                description: task.desc ?? 'desc',
                color: ref.watch(todoStateProvider.notifier).getRandomColor(),
                start: task.startTime ?? '1010',
                end: task.endTime ?? '1010',
                switcher: const SizedBox.shrink(),
              ),
          ]),
    );
  }
}
