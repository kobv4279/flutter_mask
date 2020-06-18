import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final _geolocator = Geolocator();

  Future<Position> getCurrentLocation() async{
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
    //비동기로 돌고 현재 position을 리턴해줌
    //Future<리턴타입> 함수이름 () async {  ....await }
  }

}

//외부라이브러리중에 하나이니까 내가 현재위치를 얻는 방법이 변화가 되었다면
//위치를 가져오는 로직만 고치면 된다