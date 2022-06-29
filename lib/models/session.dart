class Session {
  String? id;
  String date;
  String time;
  num ayuFee;
  num fee;
  num discount;
  num total;
  String status;
  int age;
  String firstName;
  String sex;
  String patientUid;

  Session(
      {this.id,
      required this.date,
      required this.time,
      required this.ayuFee,
      required this.fee,
      required this.discount,
      required this.total,
      required this.status,
      required this.age,
      required this.firstName,
      required this.sex,
      required this.patientUid});

  static Session fromJson(Map<String, dynamic> json) => Session(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      ayuFee: json['ayu_fee'],
      fee: json['fee'],
      discount: json['discount'],
      total: json['total'],
      status: json['status'],
      age: json['age'],
      firstName: json['first_name'],
      sex: json['sex'],
      patientUid: json['patient_uid']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'time': time,
        'ayu_fee': ayuFee,
        'fee': fee,
        'discount': discount,
        'total': total,
        'status': status,
        'age': age,
        'first_name': firstName,
        'sex': sex,
        'patient_uid': patientUid,
      };
}
