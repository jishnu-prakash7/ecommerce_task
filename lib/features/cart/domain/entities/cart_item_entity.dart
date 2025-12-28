import 'package:hive/hive.dart';

part 'cart_item_entity.g.dart';
@HiveType(typeId: 1)
class CartItemEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final num price;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final int quantity;

  CartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
