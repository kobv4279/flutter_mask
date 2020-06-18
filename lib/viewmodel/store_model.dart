import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask/model/store.dart';
import 'package:mask/repository/location_repository.dart';
import 'package:mask/repository/store_repository.dart';


class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();   //location정보는 store정보를 얻을때 필요함

  StoreModel() {   //StoreModel 클래스 생성자
    fetch();
  }

  Future fetch() async{
    isLoading = true;
    notifyListeners();

   Position position = await _locationRepository.getCurrentLocation();


    stores = await _storeRepository.fetch(
        position.latitude,
        position.longitude
    ); //동기식으로 만들기 위해서 async  await
    isLoading = false;
    notifyListeners();                        //바꼈으니까 통지


  }
}