import 'package:flutter/foundation.dart';
import 'package:mask/model/store.dart';
import 'package:mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();

  StoreModel() {   //StoreModel 클래스 생성자
    fetch();
  }

  Future fetch() async{
    isLoading = true;
    notifyListeners();


    stores = await _storeRepository.fetch(); //동기식으로 만들기 위해서 async  await
    isLoading = false;
    notifyListeners();                        //바꼈으니까 통지


  }
}