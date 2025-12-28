import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) => CartItemModel(
    id: entity.id,
    title: entity.title,
    price: entity.price,
    image: entity.image,
    quantity: entity.quantity,
  );

  CartItemEntity toEntity() => CartItemEntity(
    id: id,
    title: title,
    price: price,
    image: image,
    quantity: quantity,
  );
}
