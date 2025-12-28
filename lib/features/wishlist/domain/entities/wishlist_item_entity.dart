import 'package:hive/hive.dart';

part 'wishlist_item_entity.g.dart';

@HiveType(typeId: 2)
class WishlistItemEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final num price;
  @HiveField(3)
  final String image;

  WishlistItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
}
