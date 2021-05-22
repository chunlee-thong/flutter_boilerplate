class Pagination {
  Pagination({
    this.page,
    this.totalItems,
    this.totalPage,
  });

  int? page;
  int? totalItems;
  int? totalPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] == null ? null : json["page"],
        totalItems: json["total_items"] == null ? null : json["total_items"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
      );
}
