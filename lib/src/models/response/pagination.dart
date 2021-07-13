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
        page: json["page"] == null ? 0 : json["page"],
        totalItems: json["total_items"] == null ? 0 : json["total_items"],
        totalPage: json["total_page"] == null ? 0 : json["total_page"],
      );
}
