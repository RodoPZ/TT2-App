
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatefulWidget{
  String ?inputText;
  String inputHintText = "text";
  int? inputmax;
  double textSize;
  String? Function(String?)? myValidator;
  Function(String?)?  myOnSave;
  TextInputType ?inputType;
  List<TextInputFormatter>? inputFormatters;
  Widget? sufixWidget;
  bool isPassword;
  bool enabled;

  InputText( {this.inputText,
    required this.inputHintText,
    this.textSize = 10,
    this.inputmax,
    this.myValidator,
    this.myOnSave,
    this.inputType,
    this.inputFormatters,
    this.isPassword = false,
    this.enabled = true,
    Key? key}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  FocusNode myFocusNode = FocusNode();
  Widget? _passwordEye;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    if(widget.isPassword == true){
      setState(() {
        obscureText = true;
        _passwordEye = IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (){
            setState(() {
              obscureText = !obscureText;
            });
          },
        );
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: myFocusNode,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.inputType,
          maxLength: widget.inputmax,
            decoration: InputDecoration(
              labelText: widget.inputText,
              suffixIcon: _passwordEye,
              hintText: widget.inputHintText,
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              )
            ),
          validator: widget.myValidator,
          onSaved: widget.myOnSave,
          obscureText: obscureText,
          enableSuggestions: widget.isPassword,
          autocorrect: widget.isPassword,
          enabled: widget.enabled,


          ),
      ],
    );
  }
}