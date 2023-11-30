import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';
import 'package:todo_riverpod/features/todo/bloc/date_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';

import '../../../core/models/task_model.dart';

class UpdateTask extends StatefulWidget {
  final Task task;
  const UpdateTask({required this.task, super.key});

  @override
  State<UpdateTask> createState() => _AddPageState();
}

class _AddPageState extends State<UpdateTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late DateCubit dateCubit;
  late StartTimeCubit startTimeCubit;
  late FinishTimeCubit endTimeCubit;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title ?? '';
    descriptionController.text = widget.task.desc ?? '';
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dateCubit = BlocProvider.of<DateCubit>(context);
      startTimeCubit = BlocProvider.of<StartTimeCubit>(context);
      endTimeCubit = BlocProvider.of<FinishTimeCubit>(context);
      dateCubit.setDate(widget.task.date.toString());
      startTimeCubit.setStart(widget.task.startTime.toString());
      endTimeCubit.setFinish(widget.task.endTime.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);

    // final scheduleDate = ref.watch(dateStateProvider);
    // final startTime = ref.watch(startTimeStateProvider);
    // final endTime = ref.watch(finishTimeStateProvider);
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
                                color: AppConst.kGreen,
                                fontSize: 16)), onChanged: (date) {
                      dateCubit.setDate(date.toString().substring(0, 10));
                    }, onConfirm: (date) {
                      dateCubit.setDate(date.toString().substring(0, 10));
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
                        picker.DatePicker.showTimePicker(context,
                            onChanged: (date) {
                              startTimeCubit
                                  .setStart(date.toString().substring(10, 16));
                            },
                            showTitleActions: true,
                            onConfirm: (date) {
                              startTimeCubit
                                  .setStart(date.toString().substring(10, 16));
                            },
                            locale: picker.LocaleType.en);
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
                        picker.DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          endTimeCubit
                              .setFinish(date.toString().substring(10, 16));
                        }, onConfirm: (date) {
                          endTimeCubit
                              .setFinish(date.toString().substring(10, 16));
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
                  if (isContentNotEmpty(dateCubit.state, startTimeCubit.state,
                      endTimeCubit.state)) {
                    addTask(dateCubit.state, startTimeCubit.state,
                        endTimeCubit.state, todoCubit);
                    clearSelectedDateAndTime();

                    Navigator.pop(context);
                  } else {
                    // ref.read(checkTaskEntryProvider.notifier).state = false;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        // animation: CurvedAnimation(
                        //   parent: animationController..forward(),
                        //   curve: Curves.bounceInOut,
                        // ),
                        content: Text(
                          'Please fill all the fields',
                          style: appStyle(12, AppConst.kLight, FontWeight.bold),
                        ),
                        backgroundColor: AppConst.kBkLight,
                        behavior: SnackBarBehavior.floating,
                        // action: SnackBarAction(
                        //   label: 'Dismiss',
                        //   disabledTextColor: Colors.white,
                        //   textColor: AppConst.kYellow,
                        //   onPressed: () {},
                        // ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  addTask(String scheduleDate, String startTime, String endTime,
      TodoCubit todoCubit) {
    Task task = Task(
      id: widget.task.id,
      title: titleController.text,
      desc: descriptionController.text,
      date: scheduleDate,
      startTime: startTime,
      endTime: endTime,
      isCompleted: 0,
      remind: 0,
      repeat: "yes",
    );
    todoCubit.updateItem(task);
    // ref.read(checkTaskEntryProvider.notifier).state = true;
  }

  bool isContentNotEmpty(
      String scheduleDate, String startTime, String endTime) {
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        scheduleDate.isNotEmpty &&
        startTime.isNotEmpty &&
        endTime.isNotEmpty;
  }

  void clearSelectedDateAndTime() {
    setState(() {
    dateCubit.setDate('');
    startTimeCubit.setStart('');
    endTimeCubit.setFinish('');
     });
  }
}
