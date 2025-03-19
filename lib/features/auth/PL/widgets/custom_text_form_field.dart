import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        prefixIcon: Icon(prefixIcon),
        border: authOutlineInputBorder,
        //  OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        enabledBorder: authOutlineInputBorder,
        focusedBorder: authOutlineInputBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFFFF7643))),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

// TextFormField(
//               onSaved: (password) {},
//               onChanged: (password) {},
//               obscureText: true,
//               textInputAction: TextInputAction.next,
//               decoration: InputDecoration(
//                   hintText: "Enter your password",
//                   labelText: "Password",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   hintStyle: const TextStyle(color: Color(0xFF757575)),
                  // contentPadding: const EdgeInsets.symmetric(
                  //   horizontal: 24,
                  //   vertical: 16,
                  // ),
//                   suffix: SvgPicture.string(
//                     lockIcon,
//                   ),
//                   border: authOutlineInputBorder,
//                   enabledBorder: authOutlineInputBorder,
//                   focusedBorder: authOutlineInputBorder.copyWith(
//                       borderSide: const BorderSide(color: Color(0xFFFF7643)))),
//             ),