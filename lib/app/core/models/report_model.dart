import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  Timestamp createdAt;
  String id;
  List images;
  String note;
  String status;
  String studentId;
  String teacherId;
  String title;

  ReportModel({
    required this.createdAt,
    required this.id,
    required this.images,
    required this.note,
    required this.status,
    required this.studentId,
    required this.teacherId,
    required this.title,
  });

  factory ReportModel.fromDocument(DocumentSnapshot doc) {
    return ReportModel(
      createdAt: doc['created_at'],
      id: doc['id'],
      images: doc['images'],
      note: doc['note'],
      status: doc['status'],
      studentId: doc['student_id'],
      teacherId: doc['teacher_id'],
      title: doc['title'],
    );
  }

  Map<String, dynamic> toJson(ReportModel model) => {
        'created_at': model.createdAt,
        'id': model.id,
        'images': model.images,
        'note': model.note,
        'status': model.status,
        'student_id': model.studentId,
        'teacher_id': model.teacherId,
        'title': model.title,
      };
}
