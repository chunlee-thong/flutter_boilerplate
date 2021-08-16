class Pagination {
  Pagination({
    required this.page,
    required this.totalItems,
    required this.totalPage,
  });

  num page;
  num totalItems;
  num totalPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] ?? 0,
        totalItems: json["total_items"] ?? 0,
        totalPage: json["total_page"] ?? 0,
      );
}
