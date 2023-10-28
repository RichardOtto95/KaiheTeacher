import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/side_menu.dart';
import 'activity_history/studentActivityHistory_view.dart';
import 'health/health_view.dart';
import 'profile/studentProfile_view.dart';
import 'report_data/report_data_view.dart';
import 'student_data_controller.dart';

class StudentDataPage extends StatelessWidget {
  final StudentModel studentModel;

  const StudentDataPage({
    Key? key,
    required this.studentModel,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MainDataView(
          studentModel: studentModel,
        ),
        tablet: MainDataView(
          studentModel: studentModel,
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: 2,
              child: SideMenu(),
            ),
            Expanded(
              flex: 8,
              child: MainDataView(
                studentModel: studentModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainDataView extends StatefulWidget {
  final StudentModel studentModel;
  const MainDataView({Key? key, required this.studentModel}) : super(key: key);

  @override
  _MainDataViewState createState() => _MainDataViewState();
}

class _MainDataViewState extends State<MainDataView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeStore homeStore = Modular.get();
  final StudentDataController store = Modular.get();
  var value = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: SideMenu(),
        ),
        appBar: Responsive.isMobile(context)
            ? AppBar(
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: GrayColor,
                  ),
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
                backgroundColor: _getColor(value),
                title: Text(
                  widget.studentModel.username,
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: GrayColor,
                      fontWeight: FontWeight.bold),
                ),
                actions: value == 2 ? [
                  TextButton(
                    onPressed:(){
                      setState(() {                        
                        store.editReports = !store.editReports;
                      });
                    }, 
                    child: Text(
                      store.editReports? "Cancelar" : "Editar",
                      style: TextStyle(
                        color: store.editReports? Colors.red : null,
                      ),
                    ),
                  )
                ] : null,
              )
            : null,
        body: Container(
          padding: EdgeInsets.all(defaultPadding),
          color: _getColor(this.value),
          height: double.infinity,
          child: Column(
            children: [
              if (Responsive.isDesktop(context))
                Stack(
                  children: [
                    Center(
                      child: Text(
                        widget.studentModel.username,
                        style: TextStyle(fontSize: 39, fontWeight: FontWeight.bold),
                      ),
                    ),
                    value == 2 ?
                    Positioned(
                      right: 0,
                      child: TextButton(
                        onPressed:(){
                          setState(() {                            
                            store.editReports = !store.editReports;
                          });
                        }, 
                        child: Text(
                          store.editReports? "Cancelar" : "Editar",
                          style: TextStyle(
                            color: store.editReports? Colors.red : null,
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              if (!Responsive.isMobile(context))
                SizedBox(height: defaultPadding),
              SizedBox(
                width: 900,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: value,
                  children: tabs,
                  backgroundColor: _getColor(this.value),
                  onValueChanged: (value) {
                    setState(() {
                      this.value = value as int;
                    });
                  },
                ),
              ),
              SizedBox(height: defaultPadding),
              Expanded(
                child: this.value == 0
                    ? StudentActivityHistory(
                        studentModel: widget.studentModel,
                      )
                    : this.value == 1
                        ? StudentProfille(
                            studentModel: widget.studentModel,
                          )
                        : this.value == 2
                            ? ReportDataView(
                                studentId: widget.studentModel.id,
                              )
                            : HealthView(
                                studentModel: widget.studentModel,
                              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getColor(int value) {
    switch (value) {
      case 0:
        return HistoryColor;
      case 1:
        return ProfileColor;
      case 2:
        return ReportDataColor;
      case 3:
        return HealthColor;
      default:
    }
  }

  final Map<int, Widget> tabs = <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Histórico")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Perfil")),
    2: Padding(padding: EdgeInsets.all(10), child: Text("Relatório")),
    3: Padding(padding: EdgeInsets.all(10), child: Text("Saúde")),
  };
}
