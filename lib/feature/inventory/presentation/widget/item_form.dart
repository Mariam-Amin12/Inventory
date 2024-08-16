import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:curt_task/feature/inventory/presentation/controller/inventory_controller.dart';
import 'package:flutter/material.dart';

class ItemForm extends StatefulWidget {
  final String itemType;
  final InventoryController controller;
  final VoidCallback onItemAdded;

  ItemForm({required this.itemType, required this.controller, required this.onItemAdded});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _powerController = TextEditingController();
  final _materialController = TextEditingController();
  final _dimensionController = TextEditingController();
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _purityController = TextEditingController();
  final _weightController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Item Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                ..._buildFormFields(),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    foregroundColor: wight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    switch (widget.itemType) {
      case 'RawMaterial':
        return [
          SizedBox(height: 10),
          TextFormField(
            controller: _purityController,
            decoration: InputDecoration(labelText: 'Purity'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _typeController,
            decoration: InputDecoration(labelText: 'Type'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
        ];
      case 'Electrical':
        return [
          SizedBox(height: 10),
          TextFormField(
            controller: _voltageController,
            decoration: InputDecoration(labelText: 'Voltage'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _currentController,
            decoration: InputDecoration(labelText: 'Current'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _powerController,
            decoration: InputDecoration(labelText: 'Power'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
        ];
      case 'Mechanical':
        return [
          SizedBox(height: 10),
          TextFormField(
            controller: _materialController,
            decoration: InputDecoration(labelText: 'Material Type'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _dimensionController,
            decoration: InputDecoration(labelText: 'Dimension'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _weightController,
            decoration: InputDecoration(labelText: 'Weight'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
        ];
      default:
        return [];
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final item = {
        'item_Type': widget.itemType,
        'item_name': _nameController.text,
        'quantity': int.tryParse(_quantityController.text) ?? 0,
        'description': _descriptionController.text,
        'purity': _purityController.text.isNotEmpty
            ? double.tryParse(_purityController.text)
            : null,
        'voltage': _voltageController.text.isNotEmpty
            ? double.tryParse(_voltageController.text)
            : null,
        'current': _currentController.text.isNotEmpty
            ? double.tryParse(_currentController.text)
            : null,
        'power': _powerController.text.isNotEmpty
            ? double.tryParse(_powerController.text)
            : null,
        'material_type': _materialController.text,
        'dimension': _dimensionController.text,
        'weight': _weightController.text.isNotEmpty,
        'type': _typeController.text,
      };
      widget.controller.addItem(item);
      widget.onItemAdded(); // Call the callback to refresh the grid
      Navigator.of(context).pop(); // Close the dialog
    }
  }
}