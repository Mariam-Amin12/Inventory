import 'package:curt_task/feature/inventory/domain/entity/mechanical_entity.dart';


class MechanicalModel extends MechanicalEntity{

   MechanicalModel({required super.material, required super.dimention, required super.weight, required super.name, required super.quantity, required super.id});

  factory MechanicalModel.fromJson(Map<String, dynamic> json) {
    return MechanicalModel(
      material: json['material_type'],
      dimention: json['dymention'],
      weight: json['weight'],
      name: json['item_name'],
      quantity: json['quantity'],
      id: json['id'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'material_type': material,
      'dymention': dimention,
      'weight': weight,
      'item_name': name,
      'quantity': quantity,
      'id': id,
    };
  }




}