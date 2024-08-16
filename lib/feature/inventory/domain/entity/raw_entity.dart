import 'package:curt_task/feature/inventory/domain/entity/inventory_item.dart';

class RawEntity  extends InventoryItem{
  final String type;
  final double purity;

  RawEntity({
   required this.type,
    required this.purity, required super.name, required super.quantity, required super.id,
  });


}