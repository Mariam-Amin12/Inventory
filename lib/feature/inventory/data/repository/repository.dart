import 'package:curt_task/feature/inventory/data/model/electrical_entity.dart';
import 'package:curt_task/feature/inventory/data/model/mechanical_model.dart';
import 'package:curt_task/feature/inventory/data/model/raw_model.dart';
import 'package:curt_task/feature/inventory/domain/repository/base_repository.dart';
import 'package:curt_task/feature/inventory/data/data_sourse/data_sourse.dart';

class Repository extends BaseRepository {
  final DataSourse dataSourse;

  Repository(this.dataSourse) : super(dataSourse);



  @override
  Future<bool> addProduct(Map<String, dynamic> itemData) async {

return dataSourse.addProduct(itemData);


  }




  @override
 Future<bool> deleteProduct(Map<String, dynamic> itemData) async {
    return dataSourse.deleteProduct(itemData);

  }



  @override
  Future<List<ElectricalModel>> getElectricalProducts() async {
    return dataSourse.getElectricalProducts();
  }

  @override
  Future< List<MechanicalModel>> getMechanicalProducts() async {
    return dataSourse.getMechanicalProducts();

  }

  @override
  Future< List<RawModel>> getRawProducts() async {
    return dataSourse.getRawProducts();


  }
}