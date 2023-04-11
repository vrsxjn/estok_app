import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  String labelText;
  String hintText;
  bool readOnlyy;
  TextInputType keyboardType;
  bool obscureText;
  TextEditingController controller;
  FocusNode focusNode;
  int maxlines;
  FocusNode requestFocus;
  FormFieldValidator<String> validator;
  Icon iconz;
  GestureDetector suffixIconz;
  double fonteSize;

  FontWeight fontWeight;
  Function ontap;
  String fonte;
  List<TextInputFormatter> lista;

  CustomTextFormField(
      {@required this.labelText,
      @required this.hintText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      @required this.controller,
      this.iconz,
      this.suffixIconz,
      this.focusNode,
      this.requestFocus,
      this.maxlines = 1,
      this.validator,
      this.readOnlyy = false,
      this.fonteSize,
      this.fontWeight,
      this.fonte,
      this.lista,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: lista,
      readOnly: this.readOnlyy,
      controller: this.controller,
      maxLines: maxlines,
      keyboardType: this.keyboardType,
      focusNode: this.focusNode,
      onFieldSubmitted: (value) {
        if (this.requestFocus != null) {
          FocusScope.of(context).requestFocus(this.requestFocus);
        }
      },
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle: TextStyle(
            fontSize: fonteSize, fontWeight: fontWeight, fontFamily: fonte),
        hintText: this.hintText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF58355E),
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF58355E),
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF58355E),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF58355E))),
        contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
        prefixIcon: this.iconz,
        suffixIcon: suffixIconz,
        /*  hintStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey[600]),*/
        alignLabelWithHint: true,
      ),
      obscureText: this.obscureText,
      validator: this.validator,
      onTap: ontap,
    );
  }
}
