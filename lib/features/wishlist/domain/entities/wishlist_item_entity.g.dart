// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistItemEntityAdapter extends TypeAdapter<WishlistItemEntity> {
  @override
  final int typeId = 2;

  @override
  WishlistItemEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistItemEntity(
      id: fields[0] as num,
      title: fields[1] as String,
      price: fields[2] as num,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistItemEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItemEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
