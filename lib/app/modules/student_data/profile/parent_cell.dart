import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teacher_side/app/Model/constants.dart';

class ParentCell extends StatelessWidget {
  ParentCell({
    required this.press,
    required this.parentId,
    required this.studentName,
  });

  final VoidCallback press;
  final String parentId;
  final String studentName;

  MaskTextInputFormatter maskFormatterPhone = new MaskTextInputFormatter(
      mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')});

  MaskTextInputFormatter maskFormatterCpf = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
      child: TextButton(
        onPressed: press,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: defaultPadding / 2),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('parents').doc(parentId).get(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  DocumentSnapshot parentDoc = snapshot.data!;
                  return Row(
                    children: [
                      parentDoc['avatar'] == null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image.asset(
                          "assets/images/person.jpeg",
                          height: 82,
                          width: 82,
                          fit: BoxFit.cover,
                        ),
                      ) :
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: CachedNetworkImage(
                          imageUrl: parentDoc['avatar'],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(AppColor),
                              value: downloadProgress.progress,
                              strokeWidth: 4,
                            ),
                          ),
                          height: 82,
                          width: 82,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: defaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: studentName + " \n",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: "${parentDoc['username']} - ${parentDoc['kinship']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contato", style: TextStyle(color: TextGreyColor)),
                          Text(
                            maskFormatterPhone.maskText(parentDoc['phone']),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(height: defaultPadding),
                          Text("Documento", style: TextStyle(color: TextGreyColor)),
                          Text(
                            maskFormatterCpf.maskText(parentDoc['cpf'].toString()),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
              SizedBox(height: defaultPadding / 2),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
