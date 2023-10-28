import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class HealthView extends StatefulWidget {
  final StudentModel studentModel;
  HealthView({
    Key? key,
    required this.studentModel,
  }) : super(key: key);

  @override
  _HealthViewState createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  final HomeStore homeStore = Modular.get();

  // var _allergy = "Tem alergia a frutos do mar, poeira, ";
  // var _prescriptionDrug = "Toma Só as targas pretas";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            defaultPadding, defaultPadding, defaultPadding, defaultPadding),
        child: Responsive.isMobile(context)
            ? _mobileView()
            : Row(
                children: [_allergyView(), _emergencyView()],
              ),
      ),
    );
  }

  Widget _allergyView() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Alergia",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),
            Expanded(child: Text(widget.studentModel.allergy)),
            Text("Remédio Controlado",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),
            Expanded(child: Text(widget.studentModel.prescriptionDrug))
          ],
        ),
      ),
    );
  }

  Widget _emergencyView() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Emergência",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Qual é o tipo sanguíneo?", maxLines: 2)),
                Container(
                  width: 110,
                  height: 45,
                  decoration: BoxDecoration(
                    color: HealthColor,
                    borderRadius: new BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(widget.studentModel.bloodType),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      Text("Está autorizado a levar ao hospital?", maxLines: 2),
                ),
                Container(
                  width: 110,
                  height: 45,
                  decoration: BoxDecoration(
                    color: HealthColor,
                    borderRadius: new BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(widget.studentModel.authorizedTakeHospital),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 1.5),
            Text("Hospital",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: HealthColor,
                borderRadius: new BorderRadius.circular(12),
              ),
              child: Center(
                child: Text("Hospital de Brasília - Águas claras"),
              ),
            ),
            SizedBox(height: defaultPadding * 2),

            //if(HavePrescricao)
            Text("Prescrição Médica",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),

            SizedBox(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                        imageUrl:
                            widget.studentModel.doctorsPrescription[index],
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(AppColor),
                                value: downloadProgress.progress,
                                strokeWidth: 4,
                              ),
                            ),
                        height: 121,
                        width: 118,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileView() {
    return ListView(children: [
      SizedBox(
        // height: 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alergia",
              style: TextStyle(
                  color: TextGreyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: defaultPadding),
            Container(
              width: 900,
              height: 130,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: HealthColor,
                borderRadius: new BorderRadius.circular(20),
              ),
              child: Text(widget.studentModel.allergy),
            ),
            SizedBox(height: defaultPadding),
            Text(
              "Remédio Controlado",
              style: TextStyle(
                  color: TextGreyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: defaultPadding),
            Container(
              width: 900,
              height: 130,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: HealthColor,
                borderRadius: new BorderRadius.circular(20),
              ),
              child: Text(widget.studentModel.prescriptionDrug),
            ),
            SizedBox(height: defaultPadding),
            Text(
              "Emergência",
              style: TextStyle(
                  color: TextGreyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Qual é o tipo sanguíneo?", maxLines: 2)),
                Container(
                  width: 110,
                  height: 45,
                  decoration: BoxDecoration(
                    color: HealthColor,
                    borderRadius: new BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(widget.studentModel.bloodType),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      Text("Está autorizado a levar ao hospital?", maxLines: 2),
                ),
                Container(
                  width: 110,
                  height: 45,
                  decoration: BoxDecoration(
                    color: HealthColor,
                    borderRadius: new BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(widget.studentModel.authorizedTakeHospital),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 1.5),
            Text(
              "Hospital",
              style: TextStyle(
                  color: TextGreyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: HealthColor,
                borderRadius: new BorderRadius.circular(12),
              ),
              child: Center(
                child: Text("Hospital de Brasília - Águas claras"),
              ),
            ),
            SizedBox(height: defaultPadding * 2),
            Text("Prescrição Médica",
                style: TextStyle(
                    color: TextGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(height: defaultPadding),
            SizedBox(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.studentModel.doctorsPrescription.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                        imageUrl:
                            widget.studentModel.doctorsPrescription[index],
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(AppColor),
                                value: downloadProgress.progress,
                                strokeWidth: 4,
                              ),
                            ),
                        height: 121,
                        width: 118,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
