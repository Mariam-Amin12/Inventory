import 'package:curt_task/feature/inventory/data/data_sourse/data_sourse.dart';
import 'package:curt_task/feature/inventory/data/model/electrical_entity.dart';
import 'package:curt_task/feature/inventory/data/model/mechanical_model.dart';
import 'package:curt_task/feature/inventory/data/model/raw_model.dart';

abstract class BaseRepository {
  final DataSourse dataSourse;
  BaseRepository(this.dataSourse);

  Future<List<ElectricalModel>> getElectricalProducts();
  Future<List<RawModel>> getRawProducts();
  Future<List<MechanicalModel>> getMechanicalProducts();

  Future<bool> addProduct(Map<String, dynamic> itemData);
  Future<bool> deleteProduct(Map<String, dynamic> itemData);
}
