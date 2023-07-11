import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo_riverpod/features/todo/widgets/todo_tile.dart';
import 'package:todo_riverpod/features/todo/widgets/update_task.dart';

import '../../../core/utils/constants.dart';
import '../controllers/xpansion_provider.dart';
import 'custom_expansion_tile.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final getTomorrowDate = ref.read(todoStateProvider.notifier).getTomorrow();
    final tomorrowTodos = todos.where((todo) {
      return todo.date!.contains(getTomorrowDate);
    }).toList();
    return SizedBox(
      width: AppConst.kWidth,
      child: CustomExpansionTile(
          title: "Tomorrow's Task",
          subtitle: "Tomorrow's Task are shown below",
          onExpansionChanged: (expand) {
            ref.read(xpansionStateProvider.notifier).setState(expand);
          },
          trailing: ref.watch(xpansionStateProvider)
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
                  ref.read(todoStateProvider.notifier).deleteItem(task.id ?? 0);
                },
                editWidget: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdateTask(task: task)));
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
          ]),
    );
  }
}
