

import '../../domain/entity/electrical_entity.dart';

class ElectricalModel extends ElectricalEntity{
  ElectricalModel({required super.voltage, required super.current, required super.power, required super.name, required super.quantity, required super.id});

  factory ElectricalModel.fromJson(Map<String, dynamic> json) {
    return ElectricalModel(
      voltage: json['voltage']is String ? double.parse(json['voltage']) : json['voltage'],
      current: json['current']is String ? double.parse(json['current']) : json['current'],
      power: json['power']is String ? double.parse(json['power']) : json['power'],
      name: json['item_name'],
      quantity: json['quantity'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voltage': voltage,
      'current': current,
      'power': power,
      'item_name': name,
      'quantity': quantity,
      'id': id,
    };
  }



}