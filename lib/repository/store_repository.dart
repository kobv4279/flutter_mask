import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mask/model/store.dart';


class StoreRepository {
  //데이터를 가져오는 부분분

  Future<List<Store>> fetch() async {
    final stores = List<Store>();
//    var isLoading = true;

//    setState(() {
//      isLoading = true;
//    });

    var url = 'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.266389&lng=126.99933&m=5000';
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

//상태가 변경이 되었다고 알려주는게 setState();
//    setState(() {

      jsonStores.forEach((e){
        //Store store = Store.fromJson(e);
        stores.add(Store.fromJson(e));
      });

// });
//    isLoading = false;
      print('fetch완료');
//비동기로 수행되고 언제끝날지 모름
    //print('Response status : ${response.statusCode}');
    //print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');

    return stores;

  }

}