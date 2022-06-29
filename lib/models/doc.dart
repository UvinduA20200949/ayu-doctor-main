class Doctor {
  String name;
  String email;
  String profilePictureUrl;
  String speciality;
  String about;
  String slmc;
  String phoneNumber;
  String medicalSchool;
  String qualification;
  String profession;
  num consultationFee;
  num consultants;
  num experience;
  num ratings;
  String uid;
  bool isVerified;
  bool isPgimCertified;
  bool online;

  Doctor({
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.speciality,
    required this.about,
    required this.slmc,
    required this.phoneNumber,
    required this.medicalSchool,
    required this.qualification,
    required this.profession,
    required this.consultationFee,
    required this.consultants,
    required this.experience,
    required this.ratings,
    required this.uid,
    required this.isVerified,
    required this.isPgimCertified,
    required this.online,
  });

  static Doctor fromJson(Map<String, dynamic> json) => Doctor(
        name: json['name'],
        email: json['email'],
        profilePictureUrl: json['profile_picture_url'],
        speciality: json['speciality'],
        about: json['about'],
        slmc: json['slmc'],
        phoneNumber: json['phone_number'],
        medicalSchool: json['medical_school'],
        qualification: json['qualification'],
        profession: json['profession'],
        consultationFee: json['consultation_fee'],
        consultants: json['consultants'],
        experience: json['experience'],
        ratings: json['ratings'],
        uid: json['uid'],
        isVerified: json['is_verified'],
        isPgimCertified: json['is_pgim_certified'],
        online: json['online'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profile_picture_url': profilePictureUrl,
        'speciality': speciality,
        'about': about,
        'slmc': slmc,
        'phone_number': phoneNumber,
        'medical_school': medicalSchool,
        'qualification': qualification,
        'profession': profession,
        'consultation_fee': consultationFee,
        'consultants': consultants,
        'experience': experience,
        'ratings': ratings,
        'uid': uid,
        'is_verified': isVerified,
        'is_pgim_certified': isPgimCertified,
        'online': online,
      };
}
