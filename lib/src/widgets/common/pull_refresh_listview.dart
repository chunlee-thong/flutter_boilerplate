import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../state_widgets/no_data_widget.dart';

class PullRefreshListViewBuilder extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsets padding;
  final Future<void> Function()? onGetMoreData;
  final bool hasMoreData;
  final Axis? scrollDirection;
  final Widget? separator;
  final bool shrinkWrap;
  final Widget? onEmpty;
  final bool hasRefreshButtonWhenEmpty;
  final ScrollController? controller;
  //
  const PullRefreshListViewBuilder({
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
          padding: padding,
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
          padding: padding,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
        ),
      ),
    );
  }
}
