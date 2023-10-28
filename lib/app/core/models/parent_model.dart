import 'package:cloud_firestore/cloud_firestore.dart';

class ParentModel {
  String? id;
  String? avatar;
  String? cpf;
  String? kinship;
  String? name;
  String? phone;

  ParentModel({
    required this.id,
    required this.avatar,
    required this.cpf,
    required this.kinship,
    required this.name,
    required this.phone,
  });

  factory ParentModel.fromDocument(DocumentSnapshot doc) {
    return ParentModel(
      id: doc['id'],
      avatar: doc['avatar'],
      cpf: doc['cpf'],
      kinship: doc['kinship'],
      name: doc['name'],
      phone: doc['phone'],
    );
  }

  Map<String, dynamic> toJson(ParentModel model) => {
        'id': model.id,
        'avatar': model.avatar,
        'cpf': model.cpf,
        'kinship': model.kinship,
        'name': model.name,
        'phone': model.phone,
      };
}
