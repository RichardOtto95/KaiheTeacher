import 'package:flutter/material.dart';
import 'package:teacher_side/app/Model/constants.dart';

class CustomTextField extends StatefulWidget {
  final Color color;
  final Function(String) onChanged;
  final TextEditingController? textEditingController;
  final String? hint;

  CustomTextField(
    this.color,
    this.onChanged,
    this.textEditingController,
    this.hint,
  );
  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, defaultPadding, 0, defaultPadding),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: "  ",
            hintText: widget.hint,
          ),
          validator: (value) =>
              value!.isEmpty ? "Esse campo não pode ser vazio" : null,
          onSaved: (value) {
            // text = value!;
          },
          onChanged: widget.onChanged,
          controller: widget.textEditingController,
        ),
      ),
    );
  }
}
