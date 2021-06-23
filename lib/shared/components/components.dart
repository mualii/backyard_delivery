import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultTextButton(
        {required VoidCallback function,
        required String title,
        double? size = 20}) =>
    TextButton(
        onPressed: function,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(fontSize: size!),
        ));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  String? hint,
  int? maxLines,
  VoidCallback? onTap,
  bool isPassword = false,
  String? Function(String?)? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 10,
        ),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget DefaultItemButton(
    {required BuildContext context,
    required String title,
    required String image,
    required VoidCallback Ontap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: Ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 150.h,
        width: 0.85.sw,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xffB09B87),
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(25), color: Color(0xffB09B87)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 58.sp,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              height: 60.w,
              width: 60.w,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
