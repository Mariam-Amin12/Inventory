import 'package:curt_task/core/local/user_data.dart';
import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/core/utililes/app_strings.dart';
import 'package:curt_task/core/utililes/font_styles.dart';
import 'package:curt_task/feature/inventory/data/data_sourse/data_sourse.dart';
import 'package:curt_task/feature/inventory/data/repository/repository.dart';
import 'package:curt_task/feature/inventory/domain/use_case/use_cases_inventory.dart';
import 'package:curt_task/feature/inventory/presentation/controller/inventory_controller.dart';
import 'package:curt_task/feature/inventory/presentation/widget/item_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final LocalDataSourse _dataSourse = LocalDataSourse();
  Repository? repository;
  InventoryController? controller;

  @override
  void initState() {
    super.initState();
    repository = Repository(_dataSourse);
    controller = InventoryController(
      getElectricalProductUseCase: GetElectricalProductUseCase(repository!),
      getMechanicalProductUseCase: GetMechanicalProductUseCase(repository!),
      getRawProductUseCase: GetRawProductUseCase(repository!),
      addProductUseCase: AddProductUseCase(repository!),
      deleteProductUseCase: DeleteProductUseCase(repository!),
    );
  }

  void _refreshGrid() {
    setState(() {
      controller!.getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    FontStyles.init();
    return ChangeNotifierProvider.value(
      value: controller!,
      child: FutureBuilder<void>(
        future: controller!.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return DefaultTabController(
              length: controller!.tabs.length,
              child: Scaffold(
                backgroundColor: background,
                appBar: AppBar(
                  title: const Center(
                    child: Text(
                      AppStrings.inventory,
                      style: TextStyle(color: darkPurple),
                    ),
                  ),
                  bottom: const TabBar(
                    indicatorColor: darkPurple,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: darkPurple,
                    tabs: [
                      Tab(text: AppStrings.raw),
                      Tab(text: AppStrings.electrical),
                      Tab(text: AppStrings.mechanical),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Consumer<InventoryController>(
                        builder: (context, controller, child) {
                          return TabBarView(
                            children: controller.tabs,
                          );
                        },
                      ),
                    ),
                    UserData.userRole == "admin"
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50, // You can adjust the height as needed
                              child: ElevatedButton(
                                onPressed: () {
                                  _showAddItemDialog(context);
                                },
                                child: Text('Add Item', style: FontStyles.addItem),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkPurple,
                                  foregroundColor: wight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Item Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50, // You can adjust the height as needed
                  child: ElevatedButton(
                    onPressed: () {
                      _showItemForm(context, 'RawMaterial', controller!);
                    },
                    child: Text('Row', style: FontStyles.addItem),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkPurple,
                      foregroundColor: wight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50, // You can adjust the height as needed
                  child: ElevatedButton(
                    onPressed: () {
                      _showItemForm(context, 'Electrical', controller!);
                    },
                    child: Text('Electrical', style: FontStyles.addItem),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkPurple,
                      foregroundColor: wight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50, // You can adjust the height as needed
                  child: ElevatedButton(
                    onPressed: () {
                      _showItemForm(context, 'Mechanical', controller!);
                    },
                    child: Text('Mechanical', style: FontStyles.addItem),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkPurple,
                      foregroundColor: wight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showItemForm(BuildContext context, String itemType, InventoryController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add $itemType Item'),
          content: ItemForm(
            itemType: itemType,
            controller: controller,
            onItemAdded: _refreshGrid, // Pass the callback to refresh the grid
          ),
        );
      },
    );
  }
}