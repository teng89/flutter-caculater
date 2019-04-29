class MonthData {
  int month;
  double dygz;
  double dysb;
  double dygjj;
  double dygeshui;
  double zongnashuishouru;
  double shuilu;

  MonthData(this.month,this.dygz, this.dysb, this.dygjj,this.dygeshui,
      this.zongnashuishouru,this.shuilu);

  @override
  String toString() {
    return 'MonthData{month: $month, dygz: $dygz, dysb: $dysb, dygjj: $dygjj, dygeshui: $dygeshui, zongnashuishouru: $zongnashuishouru, shuilu: $shuilu}';
  }

}