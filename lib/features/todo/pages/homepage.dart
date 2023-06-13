import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/custom_textfield.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/spacer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>  with TickerProviderStateMixin{
  final TextEditingController searchController = TextEditingController();
  late final TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(85),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                const HeightSpacer(spaceHeight: 20),
                Row(
                  children: [
                    const Icon(
                      FontAwesome.tasks,
                      size: 20,
                      color: AppConst.kLight,
                    ),
                    const WidthSpacer(spaceWidth: 10),
                    ReusableText(
                      text: "Today's Task",
                      style: appStyle(16, AppConst.kLight, FontWeight.bold),

                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
