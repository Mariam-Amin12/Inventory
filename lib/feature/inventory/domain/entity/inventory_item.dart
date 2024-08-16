import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InventoryItem extends Equatable {
  const InventoryItem({required this.name, required this.quantity,required this.id});


  final String name;
  final int quantity;
  final int id;

  String getDescription()
  {
    return 'Name: $name, Quantity: $quantity';

  }
  @override
  List<Object?> get props => [name, quantity, id];

}
