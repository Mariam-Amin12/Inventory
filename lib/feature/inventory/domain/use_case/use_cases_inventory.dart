
import 'package:curt_task/feature/inventory/data/model/electrical_entity.dart';
import 'package:curt_task/feature/inventory/data/model/mechanical_model.dart';
import 'package:curt_task/feature/inventory/data/model/raw_model.dart';
import 'package:curt_task/feature/inventory/domain/repository/base_repository.dart';

class GetElectricalProductUseCase {
  final BaseRepository _repository;

  GetElectricalProductUseCase(this._repository);

  Future<List<ElectricalModel>> call() async {
   return _repository.getElectricalProducts();

  }
}


class GetMechanicalProductUseCase {
  final BaseRepository _repository;

  GetMechanicalProductUseCase(this._repository);

  Future<List<MechanicalModel>> call() async {
   return _repository.getMechanicalProducts();

  }
}


class GetRawProductUseCase {
  final BaseRepository _repository;

  GetRawProductUseCase(this._repository);

  Future<List<RawModel>> call() async {
   return _repository.getRawProducts();

  }
}




class AddProductUseCase {
  final BaseRepository _repository;

AddProductUseCase(this._repository);

  Future<bool> call(Map<String, dynamic> itemData) async {
   return _repository.addProduct(itemData);



  }
}



class DeleteProductUseCase {
  final BaseRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<bool> call(Map<String, dynamic> itemData) async {
   return _repository.deleteProduct(itemData);

  }
}