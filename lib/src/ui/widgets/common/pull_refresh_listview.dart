import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../constant/app_dimension.dart';
import '../state_widgets/no_data_widget.dart';

class PullRefreshListViewBuilder extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasMoreData;
  final bool hasRefreshButtonWhenEmpty;
  final Future<void> Function()? onGetMoreData;
  final EdgeInsets? padding;
  final Axis? scrollDirection;
  final Widget? separator;
  final bool shrinkWrap;
  final Widget? onEmpty;
  final ScrollController? controller;
  //
  const PullRefreshListViewBuilder({
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.onGetMoreData,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separator,
    this.shrinkWrap = false,
    this.onEmpty,
    this.controller,
    this.hasRefreshButtonWhenEmpty = false,
  });

  const PullRefreshListViewBuilder.paginated({
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    required this.onGetMoreData,
    this.padding,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separator,
    this.shrinkWrap = false,
    this.onEmpty,
    this.controller,
    this.hasRefreshButtonWhenEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return onEmpty ?? NoDataWidget(onRefresh: hasRefreshButtonWhenEmpty ? onRefresh : null);
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ConditionalWidget(
        condition: onGetMoreData != null,
        onTrue: () => SuraPaginatedList(
          padding: padding ?? AppDimension.pageSpacing,
          scrollController: controller,
          hasMoreData: hasMoreData,
          itemBuilder: itemBuilder,
          dataLoader: onGetMoreData!,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
          itemCount: itemCount,
          separator: separator ?? SizedBox(),
        ),
        onFalse: () => ListView.separated(
          controller: controller,
          separatorBuilder: (c, i) => separator ?? SizedBox(),
          padding: padding ?? AppDimension.pageSpacing,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
        ),
      ),
    );
  }
}
