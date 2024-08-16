import 'package:curt_task/core/error/faliure.dart';
import 'package:curt_task/core/local/user_access_token.dart';
import 'package:curt_task/core/network/api_service.dart';
import 'package:curt_task/feature/inventory/data/model/electrical_entity.dart';
import 'package:curt_task/feature/inventory/data/model/mechanical_model.dart';
import 'package:curt_task/feature/inventory/data/model/raw_model.dart';

abstract class DataSourse {
  Future<List<ElectricalModel>> getElectricalProducts();
  Future<List<RawModel>> getRawProducts();
  Future<List<MechanicalModel>> getMechanicalProducts();
  Future<bool> addProduct(Map<String, dynamic> itemData);
  Future<bool> deleteProduct(Map<String, dynamic> itemData);
}

class LocalDataSourse extends DataSourse {
  final ApiService apiService = ApiService();

  @override
  Future<List<ElectricalModel>> getElectricalProducts() async {
    print("going to get electrical products");

    try {
      final response = await apiService.get(
        endPoint: '/inventory/items/electrical',
        token: UserAccessToken.accessToken,
      );
      print('response $response');
      return (response.data as List).map((e) => ElectricalModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to fetch electrical products');
    }
  }

  @override
  Future<List<RawModel>> getRawProducts() async {
    print("going to get raw products");
    try {
      final response = await apiService.get(
        endPoint: '/inventory/items/raw',
        token: UserAccessToken.accessToken,
      );
      print('Response data: ${response.data}');
      List<dynamic> data = response.data;
      return data.map((e) => RawModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching raw products: $e');
      throw ServerFailure(message: 'Failed to fetch raw products');
    }
  }

  @override
  Future<List<MechanicalModel>> getMechanicalProducts() async {
    print("going to get mechanical products");

    try {
      final response = await apiService.get(
        endPoint: '/inventory/items/mechanical',
        token: UserAccessToken.accessToken,
      );
      return (response.data as List).map((e) => MechanicalModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to fetch mechanical products');
    }
  }

  @override
  Future<bool> deleteProduct(Map<String, dynamic> itemData) async {
    print('going to delete product');

    final response = await apiService.delete(
      endPoint: '/inventory/items/delete',
      data: itemData,
      token: UserAccessToken.accessToken,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data);
      
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addProduct(Map<String, dynamic> itemData) async {
    print('going to add product');

    final response = await apiService.post(
      endPoint: '/inventory/items',
      data: itemData,
      token: UserAccessToken.accessToken,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}