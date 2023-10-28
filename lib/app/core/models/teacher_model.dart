import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  String? avatar;
  String username;
  Timestamp? birthday;
  String id;
  String? phone;
  String status;
  String? country;
  Timestamp createdAt;
  List? tokenId;
  bool connected;
  String email;
  String? textMessage;

  TeacherModel({
    required this.createdAt,
    required this.avatar,
    required this.username,
    required this.birthday,
    required this.id,
    required this.phone,
    required this.status,
    required this.tokenId,
    required this.connected,
    required this.country,
    required this.email,
    required this.textMessage,
  });

  factory TeacherModel.fromDocument(DocumentSnapshot doc) {
    return TeacherModel(
      createdAt: doc['created_at'],
      avatar: doc['avatar'],
      username: doc['username'],
      birthday: doc['birthday'],
      id: doc['id'],
      phone: doc['phone'],
      status: doc['status'],
      tokenId: doc['token_id'], 
      connected: doc['connected'],
      country: doc['country'],
      email: doc['email'],
      textMessage: doc['text_message'],
    );
  }

  Map<String, dynamic> toJson(TeacherModel model) => {
        'created_at': model.createdAt,
        'avatar': model.avatar,
        'username': model.username,
        'birthday': model.birthday,
        'id': model.id,
        'phone': model.phone,
        'status': model.status,
        'token_id': model.tokenId,
        'connected': model.connected,
        'country': model.country,
        'email': model.email,
        'text_message': model.textMessage,
      };
}
