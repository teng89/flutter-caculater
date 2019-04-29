import 'package:flutter/material.dart';
import 'MonthData.dart';
import 'DataList.dart';

class FormTest extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FormSample();
  }
}

class FormSample extends State<FormTest> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  double _xinzi = 0;
  double _sbjs = 0;
  double _sbbl = 0;
  double _gjjjs = 0;
  double _gjjbl = 0;
  double _zxfj = 0;

  double _shuilv = 0.03;
  double _susuankouchu = 0;


  void _submit(BuildContext context) {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      print(_xinzi.toString() + " " + _sbjs.toString() +" "+_sbbl.toString()+" "+
          _gjjjs.toString()+" "+_gjjbl.toString()+" "+_zxfj.toString());
      _getMonthData(context);
    }
  }

  void _getMonthData(BuildContext context) {
    List<MonthData> data = new List(12);
    double dangyuenashui = 0;
    double dangyueshuihoushouru=0;
    double _zongnashuishouru = 0;
    double _zongshouru = 0;
    double _zongnashui = 0;
    double gjj = _gjjjs*(_gjjbl/100);
    double sb = _sbjs*(_sbbl/100);
    double shangyueleijinashui = 0;
    for(int i=0;i<12;i++) {
      _zongnashuishouru = _zongnashuishouru+_xinzi-5000-_zxfj-gjj-sb;
      _changeShuilv(_zongnashuishouru);
      dangyuenashui = _zongnashuishouru*_shuilv-_susuankouchu-shangyueleijinashui;
      shangyueleijinashui = shangyueleijinashui+dangyuenashui;
      dangyueshuihoushouru = _xinzi-gjj-sb-dangyuenashui;

      _zongnashui=_zongnashui+dangyuenashui;
      _zongshouru=_zongshouru+dangyueshuihoushouru;
      data[i]=new MonthData(i+1, dangyueshuihoushouru, sb, gjj,dangyuenashui,_zongnashuishouru,
      _shuilv);
    }
    for(MonthData md in data) {
      print(md.toString());
    }
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new DataList(
      list: data,
    )));

  }

   _changeShuilv(double shouru) {
    if(shouru < 36000) {
      _shuilv = 0.03;
      _susuankouchu = 0;
    } else if(36000 <shouru && shouru<=144000) {
      _shuilv = 0.1;
      _susuankouchu = 2520;
    } else if(144000<shouru && shouru<=300000) {
      _shuilv = 0.2;
      _susuankouchu = 16920;
    } else if(300000<shouru && shouru<=420000) {
      _shuilv = 0.25;
      _susuankouchu = 31920;
    } else if(420000<shouru && shouru<=660000) {
      _shuilv = 0.3;
      _susuankouchu = 52920;
    } else if(660000<shouru && shouru<=960000) {
      _shuilv = 0.35;
      _susuankouchu = 85920;
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("个税计算器"),
      ),
      body: new Container(
        height: 300,
        child: new SingleChildScrollView(
          child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "工资：",
                ),
                onSaved: (xinzi) {
                  _xinzi = double.parse(xinzi);
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "社保基数：",
                  ),
                onSaved: (sbjs) {
                  _sbjs=double.parse(sbjs);
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "社保比例：",
                  ),
                onSaved: (sbbl){
                  _sbbl=double.parse(sbbl);
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "公积金基数：",
                  ),
                onSaved: (gjjjs){
                  _gjjjs=double.parse(gjjjs);
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "公积金比例：",
                  ),
                onSaved: (gjjbl){
                  _gjjbl=double.parse(gjjbl);
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "专项附件扣除：",
                  ),
                onSaved: (zxfj){
                  _zxfj=double.parse(zxfj);
                },
              ),
            ],
          ),
        ),
      ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _submit(context);
        },
        child: new Icon(Icons.arrow_forward),
      ),
    );
  }
}