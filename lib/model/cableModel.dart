// ignore_for_file: file_names

class CableModel {
  String uid;
  String phoneNumber;
  DateTime createdAt;
  DateTime expAt;
  String email;

  CableModel({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
    required this.expAt,
    required this.email,
  });

  factory CableModel.fromMap(Map<String, dynamic> map) {
    return CableModel(
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      createdAt: map['createdAt'] ?? '',
      expAt: map['expAt'] ?? '',
      email: map['email'] ?? '',
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "phoneNumber": phoneNumber,
      "uid": uid,
      "createdAt": createdAt,
      "expAt": expAt,
      "email": email,
    };
  }
}
