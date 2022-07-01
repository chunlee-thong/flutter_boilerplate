import 'package:flutter/rendering.dart';
import 'package:future_manager/future_manager.dart';

class Pagination {
  Pagination({
    required this.page,
    required this.totalItems,
    required this.totalPage,
  });

  int page;
  int totalItems;
  int totalPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] ?? 0,
        totalItems: json["total_items"] ?? 0,
        totalPage: json["total_page"] ?? 0,
      );
}

///Extend this class from your response with pagination
class PaginationResponse<T> {
  final int totalRecord;
  List<T> data;
  PaginationResponse({required this.totalRecord, required this.data});
}

///Use this class with FutureManager to handle pagination automatically
class PaginationHandler<T extends PaginationResponse<M>, M extends Object> {
  bool hasMoreData = true;
  int page = 1;

  final FutureManager<T> manager;
  PaginationHandler(this.manager);

  void reset() {
    hasMoreData = true;
    page = 1;
  }

  T handle(T response) {
    if (manager.hasData) {
      response.data = [...manager.data!.data, ...response.data];
    }
    hasMoreData = response.data.length < response.totalRecord && response.data.isNotEmpty;
    page += 1;
    debugPrint("${manager.data.runtimeType} total length: ${response.data.length}");
    return response;
  }
}
