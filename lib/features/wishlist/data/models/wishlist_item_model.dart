import '../../domain/entities/wishlist_item_entity.dart';

class WishlistItemModel extends WishlistItemEntity {
  WishlistItemModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  factory WishlistItemModel.fromEntity(WishlistItemEntity entity) =>
      WishlistItemModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        image: entity.image,
      );

  WishlistItemEntity toEntity() => WishlistItemEntity(
    id: id,
    title: title,
    price: price,
    image: image,
  );
} 
