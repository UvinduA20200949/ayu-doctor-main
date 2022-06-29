class User {
  String name;
  String email;
  String gender;
  String nic;
  String phoneNumber;
  String bloodType;
  DateTime dateOfBirth;
  String address;
  int age;
  String uid;
  String profilePictureUrl;

  User(
      {required this.name,
      required this.email,
      required this.gender,
      required this.nic,
      required this.phoneNumber,
      required this.bloodType,
      required this.dateOfBirth,
      required this.address,
      required this.age,
      required this.uid,
      required this.profilePictureUrl});

  static User fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      nic: json['nic'],
      phoneNumber: json['phone_number'],
      bloodType: json['blood_type'],
      dateOfBirth: json['date_of_birth'],
      address: json['address'],
      age: json['age'],
      uid: json['uid'],
      profilePictureUrl: json['profilePictureUrl']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'gender': gender,
        'nic': nic,
        'phone_number': phoneNumber,
        'blood_type': bloodType,
        'date_of_birth': dateOfBirth,
        'address': address,
        'age': age,
        'uid': uid,
        'profilePictureUrl': profilePictureUrl
      };
}
