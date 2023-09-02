class ComplaintsModel {
  String uid;
  String complaint;
  String phoneNumber;
  String createdAt;
  String email;

  ComplaintsModel({
    required this.uid,
    required this.complaint,
    required this.phoneNumber,
    required this.createdAt,
    required this.email
  });

  factory ComplaintsModel.fromMap(Map<String, dynamic> map) {
    return ComplaintsModel(
      complaint: map['complaint'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      createdAt: map['createdAt'] ?? '',
      email: map['email'] ?? '',
      
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "complaint": complaint,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "createdAt": createdAt, 
      "email": email,
    };
  }
}
