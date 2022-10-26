import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../state_widgets/loading_widget.dart';
import '../state_widgets/no_data_widget.dart';

class PullRefreshListViewBuilder extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool hasMoreData;
  final bool hasRefreshButtonWhenEmpty;
  final Future<void> Function()? onGetMoreData;
  final EdgeInsets? padding;
  final Axis? scrollDirection;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool shrinkWrap;
  final Widget? onEmpty;
  final ScrollController? controller;
  final dynamic error;
  final Widget Function()? errorWidget;
  //
  const PullRefreshListViewBuilder({
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
    this.padding,
    this.onGetMoreData,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.onEmpty,
    this.controller,
    this.hasRefreshButtonWhenEmpty = true,
    this.error,
    this.errorWidget,
  }) : super(key: key);

  const PullRefreshListViewBuilder.paginated({
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    required this.onGetMoreData,
    Key? key,
    this.padding,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.onEmpty,
    this.controller,
    this.hasRefreshButtonWhenEmpty = true,
    this.error,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return onEmpty ?? NoDataWidget(onRefresh: hasRefreshButtonWhenEmpty ? onRefresh : null);
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ConditionalWidget(
        condition: onGetMoreData != null,
        onTrue: () => SkadiPaginatedListView(
          padding: padding ?? EdgeInsets.zero,
          scrollController: controller,
          hasMoreData: hasMoreData,
          itemBuilder: itemBuilder,
          dataLoader: onGetMoreData!,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
          itemCount: itemCount,
          separatorBuilder: separatorBuilder,
          hasError: error != null,
          loadingWidget: const LoadingWidget(),
          errorWidget: errorWidget?.call(),
        ),
        onFalse: () => ListView.separated(
          controller: controller,
          separatorBuilder: separatorBuilder ?? (c, i) => emptySizedBox,
          padding: padding ?? EdgeInsets.zero,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
        ),
      ),
    );
  }
}
