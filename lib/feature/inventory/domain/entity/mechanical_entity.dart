import 'package:curt_task/feature/inventory/domain/entity/inventory_item.dart';

class MechanicalEntity extends InventoryItem {
  final String material;
  final String dimention;
  final String weight;
  MechanicalEntity({

   required this.material,
   required this.dimention,
   required this.weight, required super.name, required super.quantity, required super.id,
  });
}
