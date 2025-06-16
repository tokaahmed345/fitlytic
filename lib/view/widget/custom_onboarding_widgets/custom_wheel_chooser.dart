import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/color.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class CustomWheelChooser extends StatefulWidget {
  const CustomWheelChooser({
    super.key,
    required this.maxValue,
    required this.minValue,
    required this.initValue,
    required this.onValueChanged,
  });

  final int maxValue;
  final int minValue;
  final int initValue;
  final ValueChanged<int> onValueChanged; 

  @override
  State<CustomWheelChooser> createState() => _CustomWheelChooserState();
}

class _CustomWheelChooserState extends State<CustomWheelChooser> {
  late int _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: WheelChooser.integer(
          onValueChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            widget.onValueChanged(value);
          },
          maxValue: widget.maxValue,
          minValue: widget.minValue,
          step: 1,
          initValue: _selectedItem,
          unSelectTextStyle: const TextStyle(color: AppColor.white70, fontSize: 18),
          selectTextStyle: const TextStyle(color: AppColor.wheelSelectedText, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
