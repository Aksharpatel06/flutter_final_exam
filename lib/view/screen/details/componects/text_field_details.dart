import 'package:flutter/material.dart';

import '../../../../utils/color.dart';

class TextFiledDetails extends StatelessWidget {
  const TextFiledDetails({
    super.key,
    required this.txtName,
    required this.text,
  });

  final TextEditingController txtName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == '') {
            return 'Enter The Details';
          }
          return null;
        },
        controller: txtName,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            hintText: text,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
