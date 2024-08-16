import 'package:curt_task/feature/inventory/domain/use_case/use_cases_inventory.dart';
import 'package:curt_task/feature/inventory/presentation/widget/electric_item.dart';
import 'package:curt_task/feature/inventory/presentation/widget/grid.dart';
import 'package:curt_task/feature/inventory/presentation/widget/mechanical_item.dart';
import 'package:curt_task/feature/inventory/presentation/widget/raw_item.dart';
import 'package:curt_task/feature/inventory/presentation/widget/electric_item.dart' as prefix;
import 'package:curt_task/feature/inventory/presentation/widget/raw_item.dart';
import 'package:flutter/material.dart';

class InventoryController extends ChangeNotifier {
  final GetElectricalProductUseCase getElectricalProductUseCase;
  final GetMechanicalProductUseCase getMechanicalProductUseCase;
  final GetRawProductUseCase getRawProductUseCase;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  InventoryController({
    required this.getElectricalProductUseCase,
    required this.getMechanicalProductUseCase,
    required this.getRawProductUseCase,
    required this.addProductUseCase,
    required this.deleteProductUseCase,
  });

  final List<Widget> _rawItems = [];
  final List<Widget> _electricItems = [];
  final List<Widget> _mechanicItems = [];

  final List<Widget> _tabs = [
    Grid(items: []),
    Grid(items: []),
    Grid(items: []),
  ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Widget> get tabs => _tabs;

  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  bool isUserAuthorized() {
    // Implement your user authorization logic here
    return true; // Change this to actual authorization check
  }

  Future<void> getAllProducts() async {
    final rawProducts = await getRawProductUseCase.call();
    final electricalProducts = await getElectricalProductUseCase.call();
    final mechanicalProducts = await getMechanicalProductUseCase.call();

    _rawItems.clear();
    _electricItems.clear();
    _mechanicItems.clear();

    _rawItems.addAll(rawProducts.map((product) => RawItem(rawModel: product,onDelete: getAllProducts, controller: this,)).toList());
    _electricItems.addAll(electricalProducts.map((product) => ElectricItem(electricalModel: product,onDelete:  getAllProducts,controller: this,)).toList());
    _mechanicItems.addAll(mechanicalProducts.map((product) => MechanicalItem(mechanicalModel: product,controller: this,onDelete: getAllProducts,)).toList());

    _tabs[0] = Grid(items: _rawItems);
    _tabs[1] = Grid(items: _electricItems);
    _tabs[2] = Grid(items: _mechanicItems);

    notifyListeners();
  }

  //////////////////////////  Add and Delete Items //////////////////
  Future<void> addItem(Map<String, dynamic> itemData) async {
    final success = await addProductUseCase.call(itemData);

    if (success) {
      print('Item added');
      await getAllProducts();
    }
  }

  Future<bool> deleteItem(Map<String, dynamic> itemData) async {
    return await deleteProductUseCase.call(itemData);

  }
}