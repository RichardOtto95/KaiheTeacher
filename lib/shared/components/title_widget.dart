import 'package:flutter/material.dart';

import 'package:teacher_side/app/Model/constants.dart';

Widget titleWidget(
  Color color,
  TextEditingController? textEditingController, {
  void Function(String)? onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: new BorderRadius.circular(7.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: defaultPadding,
        ),
        Text("Título:"),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: 'Título do Registro',
                // prefixText: "  ",
              ),
              validator: (value) =>
                  value!.isEmpty ? "Título não pode ser vazio" : null,
              onSaved: (value) {
                // text = value!;
              },
              controller: textEditingController,
              onChanged: onChanged,
            ),
          ),
        )
      ],
    ),
  );
}
