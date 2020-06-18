import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:mask/model/store.dart';


class StoreRepository {
  //데이터를 가져오는 부분
  final _distance = Distance();


  //위도 경도 부분을 외부에서 받도록
  Future<List<Store>> fetch(double lat, double lng) async {
    final stores = List<Store>();
//    var isLoading = true;

//    setState(() {
//      isLoading = true;
//    });

    var url = 'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m=5000';
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

//상태가 변경이 되었다고 알려주는게 setState();
//    setState(() {

      jsonStores.forEach((e){
        final store = Store.fromJson(e);
        final km = _distance.as(LengthUnit.Kilometer,
            LatLng(store.lat, store.lng), LatLng(lat, lng));
        store.km = km;
        stores.add(store);
      });

//    isLoading = false;
      print('fetch완료');
//비동기로 수행되고 언제끝날지 모름
    //print('Response status : ${response.statusCode}');
    //print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');

    return stores..sort((a,b) => a.km.compareTo(b.km));

  }

}