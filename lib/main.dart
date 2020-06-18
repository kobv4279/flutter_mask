

import 'package:flutter/material.dart';
import 'package:mask/repository/store_repository.dart';


import 'model/store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var stores = List<Store>();
  var isLoading = true;

  final storeRepository = StoreRepository();

  @override
  void initState() {
    super.initState();
      storeRepository.fetch().then((value) {
        setState(() {
          stores = value;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${stores.length}곳'),
        actions: <Widget>[
          IconButton(icon:
            Icon(Icons.refresh),
            onPressed: (){
              storeRepository.fetch().then((e){
                setState(() {
                  stores = e;
                });
              });
            },)
          ],
      ),
      body: isLoading == true
          ? loadingWidget()
          : ListView(
              children: stores.where((e) => false).map((e){
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
//변환하기전에 내가필요한것만 걸러내려면, stores.where((e)는 내가 필요한 것만 걸러냄
// =>false로 하면 어떤것만 내가 쓸거냐 false 아무조건도 없다
//children:stores.where((e){
//  return e.remainStat == 'plenty' || e.remainStat == 'some' || e.remainStat == 'few'
// })


//              children: stores.map((e) {
//                  return ListTile(
//                    title: Text(e.name),
//                    subtitle: Text(e.addr),
//                    trailing: _buildRemainStatWidget(e),
//                  );
//                }).toList(), //리스트전체를 맵핑해서 e객체를 써서
//        //이것 전체를toList() 함수를 써서 뿌리고 있다
//        //변환을 하기 전에 내가 필요한 것만 걸러내고 변환을 한다
      ),
    );
  }

  Widget _buildRemainStatWidget(Store store){
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;
    if ( store.remainStat == 'plenty'){
      remainStat = '충분';
      description = '100개이상';
      color = Colors.green;
    }
    switch (store.remainStat){
      case 'plenty':
        remainStat = '충분';
        description = '100개이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개이하';
        color = Colors.grey;
        break;
      default:

    }


    return Column(
      children: <Widget>[
        Text(remainStat, style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold),),
        Text(description, style: TextStyle(color: color),),
      ],
    );
  }


  Widget loadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
