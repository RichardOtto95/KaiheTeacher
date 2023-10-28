import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String allergy;
  String authorizedTakeHospital;
  String? avatar;
  Timestamp birthday;
  String bloodType;
  String id;
  Timestamp lastView;
  String prescriptionDrug;
  String username;
  String hospital;
  List doctorsPrescription;
  // Timestamp? createdAt;

  StudentModel({
    required this.avatar,
    required this.username,
    required this.birthday,
    required this.id,
    required this.allergy,
    required this.authorizedTakeHospital,
    required this.bloodType,
    required this.prescriptionDrug,
    required this.lastView,
    required this.doctorsPrescription,
    required this.hospital,
  });

  factory StudentModel.fromDocument(DocumentSnapshot doc) {
    return StudentModel(
      avatar: doc['avatar'],
      username: doc['username'],
      birthday: doc['birthday'],
      id: doc['id'],
      allergy: doc['allergy'],
      authorizedTakeHospital: doc['authorized_take_hospital'],
      bloodType: doc['blood_type'],
      prescriptionDrug: doc['prescription_drug'],
      lastView: doc['last_view'],
      hospital: doc['hospital'],
      doctorsPrescription: doc['doctors_prescription'],
    );
  }

  Map<String, dynamic> toJson(StudentModel model) => {
        'avatar': model.avatar,
        'username': model.username,
        'birthday': model.birthday,
        'id': model.id,
        'allergy': model.allergy,
        'authorized_take_hospital': model.authorizedTakeHospital,
        'blood_type': model.bloodType,
        'prescription_drug': model.prescriptionDrug,
        'last_view': model.lastView,
        'hospital': model.hospital,
        'doctors_prescription': model.doctorsPrescription,
      };
}
