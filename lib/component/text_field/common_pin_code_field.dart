import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CommonPinCodeField extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  const CommonPinCodeField({
    super.key,
    required this.controller,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<CommonPinCodeField> createState() => _CommonPinCodeFieldState();
}

class _CommonPinCodeFieldState extends State<CommonPinCodeField> {
  late PinInputController _pinInputController;

  @override
  void initState() {
    super.initState();
    _pinInputController = PinInputController(
      textController: widget.controller,
    );
  }

  @override
  void dispose() {
    _pinInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      length: widget.length,
      pinController: _pinInputController,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      autoFocus: true,
      keyboardType: TextInputType.number,
    );
  }
}
