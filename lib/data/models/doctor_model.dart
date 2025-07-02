class DoctorModel {
  final String? doctorId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String? liceneceNumber;
  final String? phoneNumber;
  final String? experience;
  final String? specialization;
  final String? department;
  final String? hospitalName;
  final String? address;
  final String? about;
  final String? gender;
  final String? imageUrl;
  final List<String>? degreesName;
  final List<String>? degreesUrl;

  DoctorModel({
    this.doctorId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    this.liceneceNumber,
    this.phoneNumber,
    this.experience,
    this.about,
    this.gender,
    this.imageUrl,
    this.degreesName,
    this.degreesUrl,
    this.specialization,
    this.address,
    this.department,
    this.hospitalName,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'specialization': specialization,
      'department': department,
      'address': address,
      'hospitalName': hospitalName,
      'idCard': liceneceNumber,
      'phoneNumber': phoneNumber,
      'experience': experience,
      'about': about,
      'gender': gender,
      'imageUrl': imageUrl,
      'degreesName': degreesName,
      'degreesUrl': degreesUrl,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      doctorId: map['doctorId'] ?? '',
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      specialization: map['specialization'] ?? '',
      department: map['department'] ?? '',
      address: map['address'] ?? '',
      hospitalName: map['hospitalName'] ?? '',
      liceneceNumber: map['idCard'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      experience: map['experience'] ?? '',
      about: map['about'] ?? '',
      gender: map['gender'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      degreesName: List<String>.from(map['degreesName'] ?? []),
      degreesUrl: List<String>.from(map['degreesUrl'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'specialization': specialization,
      'department': department,
      'address': address,
      'hospitalName': hospitalName,
      'idCard': liceneceNumber,
      'phoneNumber': phoneNumber,
      'experience': experience,
      'about': about,
      'gender': gender,
      'imageUrl': imageUrl,
      'degreesName': degreesName,
      'degreesUrl': degreesUrl,
    };
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'] ?? '',
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      specialization: json['specialization'] ?? '',
      department: json['department'] ?? '',
      address: json['address'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      liceneceNumber: json['idCard'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      experience: json['experience'] ?? '',
      about: json['about'] ?? '',
      gender: json['gender'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      degreesName: List<String>.from(json['degreesName'] ?? []),
      degreesUrl: List<String>.from(json['degreesUrl'] ?? []),
    );
  }
}
