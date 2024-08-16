import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/feature/inventory/data/model/mechanical_model.dart';
import 'package:curt_task/feature/inventory/presentation/controller/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:curt_task/core/local/user_data.dart';
import 'package:curt_task/feature/inventory/presentation/widget/describtion.dart';

class MechanicalItem extends StatefulWidget {
  const MechanicalItem({
    super.key,
    required this.mechanicalModel,
    required this.controller,
    required this.onDelete,
  });

  final MechanicalModel mechanicalModel;
  final InventoryController controller;
  final VoidCallback onDelete;

  @override
  _MechanicalItemState createState() => _MechanicalItemState();
}

class _MechanicalItemState extends State<MechanicalItem> {
  bool _isExpanded = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Material(
              elevation: 5.0, // Set the elevation value
              borderRadius: BorderRadius.circular(10), // Match the border radius
              child: Container(
                width: screenWidth - 16, // Full width with padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/logo.png', height: 80, width: 80),
                          SizedBox(height: 10),
                          Text(widget.mechanicalModel.name),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            if (_isExpanded) ...[
                              SizedBox(height: 10),
                              Describtion(title: 'Quantity : ', value: widget.mechanicalModel.quantity.toString()),
                              Describtion(title: 'Material : ', value: widget.mechanicalModel.material),
                              Describtion(title: 'Dimension : ', value: widget.mechanicalModel.dimention),
                              Describtion(title: 'Weight : ', value: widget.mechanicalModel.weight),
                              // Add more Describtion widgets as needed for other properties
                            ],
                          ],
                        ),
                      ) // Add the column widget
                    ],
                  ),
                ),
              ),
            ),
            if (UserData.userRole == "admin")
              Positioned(
                left: screenWidth - 100, // Adjust position based on screen width
                top: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(155, 227, 219, 225),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: _isDeleting
                        ? CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, widget.mechanicalModel.id.toString(), widget.controller);
                            },
                            icon: Icon(
                              size: 20,
                              Icons.delete,
                              color: const Color.fromARGB(255, 231, 52, 40),
                            ),
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String itemId, InventoryController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete this item?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });
                // Call the delete function
                final item = {
                  "id": itemId,
                  "item_type": "Mechanical"
                };
                bool isDeleted = await controller.deleteItem(item);
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  _isDeleting = false;
                });
                if (isDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item deleted successfully')),
                  );
                  widget.onDelete(); // Invoke the callback function
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete item')),
                  );
                }
              },
              child: Text('Confirm', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}