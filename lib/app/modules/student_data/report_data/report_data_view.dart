import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/report_model.dart';
import 'package:teacher_side/app/modules/student_data/student_data_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'activity_card_report.dart';

class ReportDataView extends StatefulWidget {
  final String studentId;
  ReportDataView({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  _ReportDataViewState createState() => _ReportDataViewState();
}

class _ReportDataViewState extends State<ReportDataView> {
  final StudentDataController store = Modular.get();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: new BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Responsive.isMobile(context)
            ? Column(
              children: [
                reportList(),
              ],
            )
            : Row(
                children: [
                  reportList(),
                  ReportScreen(),
                ],
              ),
      ),
    );
  }

  Widget reportList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentId)
          .collection('reports')
          .where('status', isEqualTo: 'ACTIVE')
          .snapshots(),
      builder: (context, reportsSnapshot) {
        print('snapshot.error: ${reportsSnapshot.error}');
        if (!reportsSnapshot.hasData ||
            reportsSnapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Container());
          // return Align(
          //   alignment: Alignment.topCenter,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          //     child: LinearProgressIndicator(),
          //   ),
          // );
        }
        QuerySnapshot<Map<String, dynamic>>? reports = reportsSnapshot.data;
        
        return Expanded(
          child: ListView.builder(
            itemCount: reports!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot reportDoc = reports.docs[index];
              return ActivityCardReport(
                reportModel: ReportModel.fromDocument(reportDoc),
                press: () {
                  if(store.reportNote != reportDoc.get('note')){
                    store.reportNote = reportDoc.get('note');
                  } else {
                    store.reportNote = '';
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ReportScreen extends StatelessWidget {
  final StudentDataController store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
            width: 400,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(20),
            ),
            child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Center(child: Text(store.reportNote))));
      }
    );
  }
}
