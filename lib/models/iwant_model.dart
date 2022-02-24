class IwantModel {
  //Verbs
  String verb1;
  String verb2;
  String v1pic;
  String v2pic;

  //Foods
  String foodT;
  String foodpic;
  String singledish_foods;
  String soup_foods;
  String fried_foods;
  String steamed_foods;
  String grilled_foods;
  String salads_foods;
  String desserts_foods;
  String fruits_foods;

  String singledish_pic;
  String soup_pic;
  String fried_pic;
  String steamed_pic;
  String grilled_pic;
  String salads_pic;
  String desserts_pic;
  String fruits_pic;


  //Drinks
  String drinkT;
  String drinkpic;
  String hotdrinks_drinks;
  String hotdrinks_pic;
  String colddrinks_drinks;
  String colddrinks_pic;
  String frappe_drinks;
  String frappe_pic;

  //Place
  String place;
  String placepic;

  //Shopping
  String shoppingT;
  String personal;
  String medicine;
  String washing;
  String shoppingpic;
  String personal_pic;
  String medicine_pic;
  String washing_pic;

  //ReadObj
  String readObj;
  String readObj_pic;

  //WatchObj
  String watchObj;
  String watchObj_pic;

  //ListenObj
  String listenTo;
  String listenTo_pic;

  //Method
  IwantModel(
      this.verb1,
      this.verb2,
      this.foodT,
      this.foodpic,
      this.drinkT,
      this.drinkpic,
      this.singledish_foods,
      this.soup_foods,
      this.fried_foods,
      this.steamed_foods,
      this.grilled_foods,
      this.salads_foods,
      this.desserts_foods,
      this.fruits_foods,
      this.singledish_pic,
      this.soup_pic,
      this.fried_pic,
      this.steamed_pic,
      this.grilled_pic,
      this.salads_pic,
      this.desserts_pic,
      this.fruits_pic,
      this.hotdrinks_drinks,
      this.hotdrinks_pic,
      this.colddrinks_drinks,
      this.colddrinks_pic,
      this.frappe_drinks,
      this.frappe_pic,
      this.place,
      this.placepic,
      this.shoppingT,
      this.personal,
      this.medicine,
      this.washing,
      this.shoppingpic,
      this.personal_pic,
      this.medicine_pic,
      this.washing_pic,
      this.readObj,
      this.readObj_pic,
      this.watchObj,
      this.watchObj_pic,
      this.listenTo,
      this.listenTo_pic);

  IwantModel.fromMap(Map<String, dynamic> map) {
    verb1 = map['verb1'];
    verb2 = map['verb2'];
    v1pic = map['v1pic'];
    v2pic = map['v2pic'];

    singledish_foods = map['Sdname'];
    soup_foods = map['Spname'];
    fried_foods = map['Fdname'];
    steamed_foods = map['Stname'];
    grilled_foods = map['Grname'];
    salads_foods = map['Slname'];
    desserts_foods = map['Dsname'];
    fruits_foods = map['Funame'];

    singledish_pic = map['Sdpic'];
    soup_pic = map['Sppic'];
    fried_pic = map['Fdpic'];
    steamed_pic = map['Stpic'];
    grilled_pic = map['Grpic'];
    salads_pic = map['Slpic'];
    desserts_pic = map['Dspic'];
    fruits_pic = map['Fupic'];


    foodT = map['Ftype'];
    foodpic = map['Ftpic'];

    drinkT = map['Dtype'];
    drinkpic = map['Dtpic'];
    hotdrinks_drinks = map['Hdname'];
    hotdrinks_pic = map['Hdpic'];
    colddrinks_drinks = map['Cdname'];
    colddrinks_pic = map['Cdpic'];
    frappe_drinks = map['Frname'];
    frappe_pic = map['Frpic'];

    place = map['Plname'];
    placepic = map['Plpic'];

    shoppingT = map['Shtype'];
    personal = map['Shname'];
    medicine = map['Mdname'];
    washing = map['Wsname'];
    shoppingpic = map['Shtpic'];
    personal_pic = map['Shpic'];
    medicine_pic = map['Mdpic'];
    washing_pic = map['Wspic'];

    readObj = map['Roname'];
    readObj_pic = map['Ropic'];

    watchObj = map['Wcname'];
    watchObj_pic = map['Wcpic'];

    listenTo = map['Lsname'];
    listenTo_pic = map['Lspic'];
  }
}
