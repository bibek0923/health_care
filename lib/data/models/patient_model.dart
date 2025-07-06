class PatientModel {
  final String? id;
  final String? imageUrl;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? idCardNumber;
  final String? phoneNumber;
  final String? height;
  final String? weight;
  final String? age;
  final String? bloodGroup;
  final String? about;
  final String? gender;
  final String? reportUrl;
  final String? guardianName;
  final String? guardianIdCard;
  final String? guardianPhoneNumber;
  final String? guardianRelationShip;
  final String? guardianGender;
  final String? insuranceCard;
  final String? heightUnit;
  final String? weightUnit;

  PatientModel({
    this.id,
    this.imageUrl,
    this.middleName,
    this.firstName,
    this.guardianRelationShip,
    this.insuranceCard,
    this.guardianGender,
    this.lastName,
    this.email,
    this.idCardNumber,
    this.phoneNumber,
    this.height,
    this.weight,
    this.age,
    this.bloodGroup,
    this.about,
    this.gender,
    this.reportUrl,
    this.guardianName,
    this.guardianIdCard,
    this.guardianPhoneNumber,
    this.heightUnit,
    this.weightUnit,
  });

  /// Convert the model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'middleName': middleName,
      'firstName': firstName,
      'guardianRelationShip': guardianRelationShip,
      'insuranceCard': insuranceCard,
      'guardianGender': guardianGender,
      'lastName': lastName,
      'email': email,
      'idCardNumber': idCardNumber,
      'phoneNumber': phoneNumber,
      'height': height,
      'weight': weight,
      'age': age,
      'bloodGroup': bloodGroup,
      'about': about,
      'gender': gender,
      'reportUrl': reportUrl,
      'guardianName': guardianName,
      'guardianIdCard': guardianIdCard,
      'guardianPhoneNumber': guardianPhoneNumber,
      'heightUnit': heightUnit,
      'weightUnit': weightUnit,
    };
  }

  /// Explicit JSON serialization method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'middleName': middleName,
      'guardianRelationShip': guardianRelationShip,
      'insuranceCard': insuranceCard,
      'guardianGender': guardianGender,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'idCardNumber': idCardNumber,
      'phoneNumber': phoneNumber,
      'height': height,
      'weight': weight,
      'age': age,
      'bloodGroup': bloodGroup,
      'about': about,
      'gender': gender,
      'reportUrl': reportUrl,
      'guardianName': guardianName,
      'guardianIdCard': guardianIdCard,
      'guardianPhoneNumber': guardianPhoneNumber,
      'heightUnit': heightUnit,
      'weightUnit': weightUnit,
    };
  }

  /// Create model from Firestore map
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      middleName: map['middleName'] ?? '',
      guardianGender: map['guardianGender'] ?? '',
      insuranceCard: map['insuranceCard'] ?? '',
      firstName: map['firstName'] ?? '',
      guardianRelationShip: map['guardianRelationShip'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      idCardNumber: map['idCardNumber'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      age: map['age'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      about: map['about'] ?? '',
      gender: map['gender'] ?? '',
      reportUrl: map['reportUrl'] ?? '',
      guardianName: map['guardianName'] ?? '',
      guardianIdCard: map['guardianIdCard'] ?? '',
      guardianPhoneNumber: map['guardianPhoneNumber'] ?? '',
      weightUnit: map['weightUnit'] ?? '',
      heightUnit: map['heightUnit'] ?? '',
    );
  }

  /// Create model from JSON map
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      middleName: json['middleName'] ?? '',
      guardianGender: json['guardianGender'] ?? '',
      insuranceCard: json['insuranceCard'] ?? '',
      firstName: json['firstName'] ?? '',
      guardianRelationShip: json['guardianRelationShip'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      idCardNumber: json['idCardNumber'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      age: json['age'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      about: json['about'] ?? '',
      gender: json['gender'] ?? '',
      reportUrl: json['reportUrl'] ?? '',
      guardianName: json['guardianName'] ?? '',
      guardianIdCard: json['guardianIdCard'] ?? '',
      guardianPhoneNumber: json['guardianPhoneNumber'] ?? '',
      weightUnit: json['weightUnit'] ?? '',
      heightUnit: json['heightUnit'] ?? '',
    );
  }
}
