import 'package:curt_task/feature/inventory/domain/entity/raw_entity.dart';

class RawModel extends RawEntity{
  RawModel({required super.type, required super.purity, required super.name, required super.quantity, required super.id});

  factory RawModel.fromJson(Map<String, dynamic> json) {
   return RawModel(
      id: json['id'],
      name: json['item_name'],
      quantity: json['quantity'],
      type: json['type'],
      purity: json['purity'] is String ? double.parse(json['purity']) : json['purity'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'purity': purity,
      'item_name': name,
      'quantity': quantity,
      'id': id,
    };
  }



}