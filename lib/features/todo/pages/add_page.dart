import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';
import 'package:todo_riverpod/features/auth/widgets/alert_dialog_box.dart';
import 'package:todo_riverpod/features/todo/bloc/date_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';

import '../../../core/helpers/notification_helper.dart';
import '../../../core/models/task_model.dart';
import 'homepage.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late NotificationHelper notificationHelper;
  late NotificationHelper notificationController;
  List<int> notification = [];

  // late AnimationController animationController;
  @override
  void initState() {
    notificationHelper = NotificationHelper(ref: ref);
    notificationController = NotificationHelper(ref: ref);
    notificationHelper.initializeNotification();

    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final scheduleDate = BlocProvider.of<DateCubit>(context);
    final startTime = BlocProvider.of<StartTimeCubit>(context);
    final endTime = BlocProvider.of<FinishTimeCubit>(context);
    final todoCubit= BlocProvider.of<TodoCubit>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppConst.kLight,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomTextFormField(
                hintText: 'Enter your Title',
                controller: titleController,
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomTextFormField(
                hintText: 'Enter your Description',
                controller: descriptionController,
                // hintStyle: appStyle(16, AppConst.kGreyLight, FontWeight.normal),
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              BlocBuilder<DateCubit, String>(builder: (context, state) {
                return CustomOutlineButton(
                  borderColor: AppConst.kLight,
                  height: 52.h,
                  bgColor: AppConst.kBlueLight,
                  text: state.isEmpty ? 'Set Date' : state,
                  width: AppConst.kWidth,
                  onPressed: () {
                    picker.DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime:
                            DateTime.now().add(const Duration(days: 365 * 2)),
                        theme: const picker.DatePickerTheme(
                            headerColor: Colors.white,
                            itemStyle: TextStyle(
                                color: AppConst.kBlueLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: AppConst.kGreen, fontSize: 16)),
                        //     onChanged: (date) {
                        //   if (kDebugMode) {
                        //     log('change $date in time zone ${date.timeZoneOffset.inHours}');
                        //   }
                        // },
                        onConfirm: (date) {
                      scheduleDate.setDate(date.toString().substring(0, 10));
                    },
                        currentTime: DateTime.now(),
                        locale: picker.LocaleType.en);
                  },
                );
              }),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<StartTimeCubit, String>(
                      builder: (context, state) {
                    return CustomOutlineButton(
                      borderColor: AppConst.kLight,
                      height: 52.h,
                      bgColor: AppConst.kBlueLight,
                      text: state.isEmpty ? 'Start Time' : state,
                      width: AppConst.kWidth * 0.4,
                      onPressed: () {
                        picker.DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onConfirm: (date) {
                          notification = startTime.dates(date);
                          startTime.setStart(date.toString().substring(10, 16));
                        }, locale: picker.LocaleType.en);
                      },
                    );
                  }),
                  BlocBuilder<FinishTimeCubit, String>(
                      builder: (context, state) {
                    return CustomOutlineButton(
                      borderColor: AppConst.kLight,
                      height: 52.h,
                      bgColor: AppConst.kBlueLight,
                      text: state.isEmpty ? 'End Time' : state,
                      width: AppConst.kWidth * 0.4,
                      onPressed: () {
                        picker.DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onConfirm: (date) {
                          endTime.setFinish(date.toString().substring(10, 16));
                        }, locale: picker.LocaleType.en);
                      },
                    );
                  }),
                ],
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomOutlineButton(
                borderColor: AppConst.kLight,
                height: 52.h,
                bgColor: AppConst.kGreen,
                text: 'Submit',
                width: AppConst.kWidth,
                onPressed: () {
                  if (isContentNotEmpty(
                      scheduleDate.state, startTime.state, endTime.state)) {
                    addTask(scheduleDate.state, startTime.state, endTime.state, todoCubit);
                    // clearSelectedDateAndTime();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  } else {
                    ref.read(checkTaskEntryProvider.notifier).state = false;
                    showAlertDialog(
                        context: context, message: "Failed to add task");
                  }
                },
              ),
            ],
          ),
        ));
  }

  addTask(String scheduleDate, String startTime, String endTime,TodoCubit todoCubit) {
    Task task = Task(
      title: titleController.text,
      desc: descriptionController.text,
      date: scheduleDate,
      startTime: startTime,
      endTime: endTime,
      isCompleted: 0,
      remind: 0,
      repeat: "yes",
    );
    notificationHelper.scheduleNotification(notification[0], notification[1],
        notification[2], notification[3], task);
    todoCubit.addItem(task);
    // ref.read(todoStateProvider.notifier).addItem(task);
    ref.read(checkTaskEntryProvider.notifier).state = true;
  }

  bool isContentNotEmpty(
      String scheduleDate, String startTime, String endTime) {
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        scheduleDate.isNotEmpty &&
        startTime.isNotEmpty &&
        endTime.isNotEmpty;
  }

  void clearSelectedDateAndTime(dateCubit, startTimeCubit, finishTimeCubit) {
    // ref.read(dateStateProvider.notifier).setDate('');
    // ref.read(startTimeStateProvider.notifier).setStart('');
    // ref.read(finishTimeStateProvider.notifier).setFinish('');
    dateCubit.setDate('');
    startTimeCubit.setStart('');
    finishTimeCubit.setFinish('');
  }
}
