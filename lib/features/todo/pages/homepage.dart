import 'package:flutter/material.dart';
import 'package:todo_riverpod/features/todo/controllers/xpansion_provider.dart';
import '../../../core/widgets/core_widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/constants.dart';

import '../widgets/custom_expansion_tile.dart';
import '../widgets/todo_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  var toggleSwitch = StateProvider.autoDispose<bool>(
    (ref) => false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConst.kGreyDk,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(85.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Dashboard',
                        style: appStyle(18, AppConst.kLight, FontWeight.bold),
                      ),
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
                            onTap: () {},
                            child: const Icon(Ionicons.add,
                                color: AppConst.kBkDark),
                          ))
                    ],
                  ),
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
                  ],
                ),
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
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        Container(
                          height: AppConst.kHeight * 0.3,
                          decoration: BoxDecoration(
                            color: AppConst.kBkDark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppConst.kRadius),
                            ),
                          ),
                          child: ListView(
                            children: [
                              TodoTile(
                                start: '9:00',
                                end: '11:00',
                                switcher: Switch(
                                  activeColor: AppConst.kLight,
                                  activeTrackColor: AppConst.kGreen,
                                  onChanged: (bool value) {
                                    ref.read(toggleSwitch.notifier).state =
                                        value;
                                  },
                                  value: ref.watch(toggleSwitch),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomExpansionTile(
                            title: 'Completed Task 2',
                            subtitle: 'Buy Grocericies this week',
                            onExpansionChanged: (toggle) {
                              ref
                                  .read(xpansionStateProvider.notifier)
                                  .setState(!toggle);
                            },
                            trailing: ref.watch(xpansionStateProvider)
                                ? const Icon(
                                    AntDesign.circledown,
                                    color: AppConst.kLight,
                                  )
                                : const Icon(
                                    AntDesign.closecircleo,
                                    color: AppConst.kBlueLight,
                                  ),
                            children: [
                              TodoTile(
                                start: '9:00',
                                end: '11:00',
                                switcher: Switch(
                                  activeColor: AppConst.kLight,
                                  activeTrackColor: AppConst.kGreen,
                                  onChanged: (bool value) {
                                    ref.read(toggleSwitch.notifier).state =
                                        value;
                                  },
                                  value: ref.watch(toggleSwitch),
                                ),
                              ),
                            ]),
                      ]),
                ),
                const HeightSpacer(spaceHeight: 20),
                CustomExpansionTile(
                    title: 'Todo Task 2',
                    subtitle: 'Buy Grocericies this week',
                    onExpansionChanged: (toggle) {
                      ref
                          .read(xpansionStateProvider.notifier)
                          .setState(!toggle);
                    },
                    trailing: ref.watch(xpansionStateProvider)
                        ? const Icon(
                            AntDesign.circledown,
                            color: AppConst.kLight,
                          )
                        : const Icon(
                            AntDesign.closecircleo,
                            color: AppConst.kBlueLight,
                          ),
                    children: [
                      TodoTile(
                        start: '9:00',
                        end: '11:00',
                        switcher: Switch(
                          activeColor: AppConst.kLight,
                          activeTrackColor: AppConst.kGreen,
                          onChanged: (bool value) {
                            ref.read(toggleSwitch.notifier).state = value;
                          },
                          value: ref.watch(toggleSwitch),
                        ),
                      ),
                    ]),
                const HeightSpacer(spaceHeight: 20),
                const CustomExpansionTile(
                    title: "Todo Task 3",
                    subtitle: 'Buy Grocericies this week',
                    children: []),
              ],
            ),
          ),
        ));
  }
}
