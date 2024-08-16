class CategoryEntity {
  CategoryEntity({
    this.data,
  });

  List<DataEntity>? data;
}

class DataEntity {
  DataEntity({
    this.id,
    this.name,
    this.image,
  });

  String? id;
  String? name;
  String? image;
}
