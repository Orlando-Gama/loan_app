class product{

  List<String>? image;
  String? category;
  String? createdAt;
  int? amount;
  String? transid;
  int? total;
  double? percentages;
  String? time;
  String? type;
  String? uid;
  String? fee;
  String? status;
  String? seen;
  String? confirmed;
  String? period;


  product(
      {

        this.category,
        this.createdAt,
        this.amount,
        this.transid,
        this.total,
        this.percentages,
        this.time,
        this.type,
        this.uid,
        this.fee,

        this.status,
        this.seen,
        this.confirmed,
        this.period,
        this.image,

      }
      );
  factory product.fromJson(Map<String, dynamic> map, {required String id}) => product(


    category: map['category'],
    createdAt: map['createdAt'],
    amount: map['amount'],
    transid: map['transid'],
    total: map['total'],
    percentages: map['percentages'],

    time: map['time'],
    type: map['type'],
    uid: map['uid'],
    fee: map['fee'],
    period: map['period'],
    status: map['status'],
    seen: map['seen'],
    confirmed: map['confirmed'],

    image: map["image"].map<String>((i) => i as String).toList(),
  );
  Map<String, dynamic>toMap(){
    return{

      "category":category,
      "createdAt":createdAt,
      "amount":amount,
      "transid":transid,
      "total":total,
      "percentages":percentages,
      "time":time,
      "type":type,
      "uid":uid,
      "fee":fee,
      "status":status,
      "seen":seen,
      "confirmed":confirmed,
      "image": image




    };
  }
}