
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';

class ProductsListModel extends ProductsListEntity {
  ProductsListModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  /// JSON → Model
  factory ProductsListModel.fromJson(Map<String, dynamic> json) =>
      ProductsListModel( 
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        price: (json["price"] ?? 0),
        description: json["description"] ?? "",
        category: json["category"] ?? "",
        image: json["image"] ?? '',
        rating: Rating.fromJson(json["rating"] ?? {}),
      );

  /// Entity → Model
  factory ProductsListModel.fromEntity(ProductsListEntity entity) =>
      ProductsListModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        rating: Rating.fromEntity(entity.rating),
      );

  /// Model → JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": (rating as Rating).toJson(),
  };

  /// Model → Entity
  ProductsListEntity toEntity() => ProductsListEntity(
    id: id,
    title: title,
    price: price,
    description: description,
    category: category,
    image: image,
    rating: rating,
  );
}

class Rating extends RatingEntity {
  Rating({required super.rate, required super.count});

  /// JSON → Model
  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: (json["rate"] ?? 0), count: json["count"]??0);

  /// Entity → Model
  factory Rating.fromEntity(RatingEntity entity) =>
      Rating(rate: entity.rate, count: entity.count);

  /// Model → JSON
  Map<String, dynamic> toJson() => {"rate": rate, "count": count};

  /// Model → Entity
  RatingEntity toEntity() => RatingEntity(rate: rate, count: count);
}
