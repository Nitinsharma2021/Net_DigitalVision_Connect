// ignore_for_file: file_names

class OttModel {
  String uid;
  String phoneNumber;
  DateTime createdAt;
  DateTime expAt;
  String email;

  OttModel({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
    required this.expAt,
    required this.email,
  });

  factory OttModel.fromMap(Map<String, dynamic> map) {
    return OttModel(
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
      "email": email,
      "createdAt": createdAt,
      "expAt": expAt,
    };
  }
}
