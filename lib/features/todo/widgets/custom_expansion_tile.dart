import 'package:flutter/material.dart';
import 'package:todo_riverpod/features/todo/widgets/button_title.dart';

import '../../../core/utils/constants.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final Function(bool)? onExpansionChanged;

  final Function()? onTrailingIconPressed;

  final Widget? trailing;
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTrailingIconPressed,
    required this.children,
    this.trailing,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConst.kWidth,
      decoration: BoxDecoration(
        color: AppConst.kBkDark,
        borderRadius: BorderRadius.circular(AppConst.kRadius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,

          // unselectedWidgetColor: AppConst.kLight,
        ),
        child: ExpansionTile(
          // title: Text('sada'),
          title: ButtonTitle(
            title: title,
            subtitle: subtitle,
            leadingColor: AppConst.kBlueLight,
          ),
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
