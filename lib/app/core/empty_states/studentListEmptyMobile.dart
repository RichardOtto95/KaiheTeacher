import 'package:flutter/material.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class StudentListEmptyMobile extends StatelessWidget {
  const StudentListEmptyMobile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Responsive.isMobile(context)? Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Image.asset('assets/images/SelecioneAluno_iphone.png')
            
          ),
        ) :
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Image.asset('assets/images/semAlunoSelecionado_ipad.png'),
          ),
        )
        
      
      
    );
  }
}