import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask/UI/widget/remain_stat_list_tile.dart';
import 'package:mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';


class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: <Widget>[
          IconButton(icon:
          Icon(Icons.refresh),
            onPressed: (){
              storeModel.fetch();

            },)
        ],
      ),
      body: storeModel.isLoading == true
          ? loadingWidget()
          : ListView(
        children: storeModel.stores.map((e){
          return RemainStatListTile(e);
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
