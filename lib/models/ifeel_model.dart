class IfeelModel {
  //Adjectives: Ifadj
  String adjective;
  String adjpic;

  //Pain
  String pain;
  String painpic;

  
  //Method
  IfeelModel(
      this.adjective,
      this.adjpic,
      this.pain,
      this.painpic);

  IfeelModel.fromMap(Map<String, dynamic> map) {
    adjective = map['Adj'];
    adjpic = map['Adjpic'];

    pain= map['Pnname'];
    painpic = map['Pnpic'];
    
  }
}
