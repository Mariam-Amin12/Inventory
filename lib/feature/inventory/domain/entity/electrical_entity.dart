// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:curt_task/feature/inventory/domain/entity/inventory_item.dart';

class ElectricalEntity extends InventoryItem {
  final double voltage;
  final double current;
  final double power;

  ElectricalEntity({
    required this.voltage,
   required this.current,
   required this.power, required super.name, required super.quantity, required super.id,
  });




}
