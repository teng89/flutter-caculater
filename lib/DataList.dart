import 'package:flutter/material.dart';
import 'MonthData.dart';

class DataList extends StatelessWidget {

  DataList({Key key, @required this.list}) : super(key: key);

  final List<MonthData> list;

  double _getTotal(int i) {
    double result = 0.0;
    switch(i) {
      case 0:
        for(int i=0;i<list.length;i++) {
          result = result + list[i].dygz;
        }
        break;
      case 1:
        for(int i=0;i<list.length;i++) {
          result = result + list[i].dysb;
        }
        break;
      case 2:
        for(int i=0;i<list.length;i++) {
          result = result + list[i].dygjj;
        }
        result=result*2;
        break;
      case 3:
        for(int i=0;i<list.length;i++) {
          result = result + list[i].dygeshui;
        }
        break;
      case 4:
        for(int i=0;i<list.length;i++) {
          result = result + list[i].dygz + list[i].dygjj*2;
        }
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("list 1:" + list[0].toString());
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("计算结果"),
        leading: new GestureDetector(
          child: Icon(Icons.arrow_back,),
          onTap: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: new Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: 400,
            width: 500,
            alignment: AlignmentDirectional.centerStart,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context,position) {
                  return new MyItem(
                    data: list[position],
                  );
                }),
          ),
          new Divider(color: Colors.lightBlue,),
          new Text("  全年税后收入:" + _getTotal(0).toInt().toString()),
          new Text("  全年社保总额:" +  _getTotal(1).toInt().toString()),
          new Text("  全年公积金（公司+个人）:" +  _getTotal(2).toInt().toString()),
          new Text("  全年纳税总额:" +  _getTotal(3).toInt().toString()),
          new Text("  全年总收入（税后工资+公积金总额）:" +  _getTotal(4).toInt().toString()),
        ],
      )
    );
  }
}

class MyItem extends StatelessWidget {

  MyItem({Key key,@required this.data}):super(key: key);

  final MonthData data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("data :" + data.toString());
    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: new Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.start,
          children: <Widget>[
            new Text("月份："+data.month.toString(),
              textAlign: TextAlign.start,
            ),
          new Row(
            children: <Widget>[
              new Text("税后工资:"+data.dygz.toInt().toString(),
                textAlign: TextAlign.start,
              ),
              new Text("   当月个税:" + data.dygeshui.toInt().toString(),
                textAlign: TextAlign.end,
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              new Text("社保:"+data.dysb.toInt().toString()),
              new Text("  公积金:" + data.dygjj.toInt().toString()),
            ],
          ),
          new Divider(),
        ],
      ),
    );
  }
}