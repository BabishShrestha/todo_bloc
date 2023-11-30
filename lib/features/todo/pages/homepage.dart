import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/auth/bloc/auth_cubit.dart';
import 'package:todo_riverpod/features/todo/bloc/todo_cubit.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/core_widgets.dart';
import '../widgets/completed_task.dart';
import '../widgets/day_after_tomrrow_list.dart';
import '../widgets/todaytask.dart';
import '../widgets/tomorrow_list.dart';
import 'add_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// final checkTaskEntryProvider = StateProvider.autoDispose<bool>((ref) => false);

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (ref.read(checkTaskEntryProvider)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         duration: const Duration(seconds: 1),
  //         content: Text(
  //           'Your task has been added successfully',
  //           style: appStyle(12, AppConst.kLight, FontWeight.bold),
  //         ),
  //         backgroundColor: AppConst.kBkLight,
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final todoCubit= BlocProvider.of<TodoCubit>(context);
    todoCubit.refresh();

    return Scaffold(
        floatingActionButton: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppConst.kBkLight,
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: AppConst.kLight,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()));
              },
              child: const Icon(Ionicons.add, color: AppConst.kBkDark),
            )),
        backgroundColor: AppConst.kGreyDk,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(85.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ReusableText(
                        text: 'Dashboard',
                        style: appStyle(18, AppConst.kLight, FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          //insert alert prompt for log out confirm
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: const Text('Logout'),
                                    content: const Text(
                                        'Are you sure you want to log out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform logout action here
                                          authCubit.signOut();

                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/login',
                                              (route) => false);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('No'),
                                      ),
                                    ]);
                              });
                          // ref.read(authControllerProvider).signOut();

                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, '/login', (route) => false);
                        },
                        child: const Icon(
                          Ionicons.log_out_outline,
                          color: AppConst.kLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const HeightSpacer(spaceHeight: 20),
                CustomTextFormField(
                    hintText: 'Search',
                    hintStyle:
                        appStyle(12, AppConst.kGreyLight, FontWeight.bold),
                    controller: searchController,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(14.h),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(AntDesign.search1,
                            color: AppConst.kGreyLight),
                      ),
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.all(14.h),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(FontAwesome.sliders,
                            color: AppConst.kGreyLight),
                      ),
                    )),
                const HeightSpacer(spaceHeight: 15),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            // height: AppConst.kHeight * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                const HeightSpacer(spaceHeight: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesome.tasks,
                      size: 20,
                      color: AppConst.kLight,
                    ),
                    const WidthSpacer(spaceWidth: 10),
                    ReusableText(
                      text: "Today's Task",
                      style: appStyle(14, AppConst.kLight, FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppConst.kLight,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppConst.kRadius - 3),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddPage()));
                          },
                          child:
                              const Icon(Ionicons.add, color: AppConst.kBkDark),
                        ))
                  ],
                ),
                const HeightSpacer(spaceHeight: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppConst.kRadius),
                    ),
                  ),
                  child: TabBar(
                      controller: tabController,
                      labelPadding: EdgeInsets.zero,
                      labelColor: AppConst.kBkDark,
                      labelStyle:
                          appStyle(14, AppConst.kBkDark, FontWeight.bold),
                      unselectedLabelColor: AppConst.kLight,
                      indicator: BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppConst.kRadius),
                        ),
                      ),
                      // indicatorColor: AppConst.kBkDark,
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: AppConst.kWidth * 0.5,
                            child: Center(
                              child: ReusableText(
                                text: 'Pending',
                                style: appStyle(
                                    10, AppConst.kBkDark, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            width: AppConst.kWidth * 0.5,
                            child: Center(
                              child: ReusableText(
                                text: 'Completed',
                                style: appStyle(
                                    10, AppConst.kBkDark, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const HeightSpacer(spaceHeight: 20),
                SizedBox(
                  height: AppConst.kHeight * 0.3,
                  width: AppConst.kWidth,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: const [
                        TodayTask(),
                        CompletedTaskList(),
                      ]),
                ),
                const HeightSpacer(spaceHeight: 20),
                const TomorrowList(),
                const HeightSpacer(spaceHeight: 20),
                const DayAfterTomorrowList(),
              ],
            ),
          ),
        ));
  }
}
