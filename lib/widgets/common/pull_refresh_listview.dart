import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../state_widgets/no_data_widget.dart';

class PullRefreshListViewBuilder extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsets padding;
  final Function onGetMoreData;
  final bool hasMoreData;
  final Axis scrollDirection;
  final Widget separator;
  final bool shrinkWrap;
  final Widget onEmpty;
  final bool hasRefreshButtonWhenEmpty;
  //
  const PullRefreshListViewBuilder({
    @required this.onRefresh,
    @required this.itemCount,
    @required this.itemBuilder,
    this.padding,
    this.onGetMoreData,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separator,
    this.shrinkWrap = false,
    this.onEmpty,
    this.hasRefreshButtonWhenEmpty = false,
  });

  const PullRefreshListViewBuilder.paginated({
    @required this.onRefresh,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onGetMoreData,
    this.padding,
    this.hasMoreData = false,
    this.scrollDirection,
    this.separator,
    this.shrinkWrap = false,
    this.onEmpty,
    this.hasRefreshButtonWhenEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return onEmpty ?? NoDataWidget(onRefresh: hasRefreshButtonWhenEmpty ? onRefresh : null);
    }
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ConditionalWidget(
        condition: onGetMoreData != null,
        onTrue: PaginatedListView(
          padding: padding,
          hasMoreData: hasMoreData,
          itemBuilder: itemBuilder,
          onGetMoreData: onGetMoreData,
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection ?? Axis.vertical,
          itemCount: itemCount,
          divider: separator ?? SizedBox(),
        ),
        onFalse: ListView.separated(
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
