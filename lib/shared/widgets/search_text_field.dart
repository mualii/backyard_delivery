import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.brown.shade50,
      color: Color(0xffF5F5F5),
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        style: TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.transparent)),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0xff80392C), fontSize: 42.sp),
          prefixIcon: Icon(
            Icons.search,
            size: 30,
            color: Colors.brown.shade200,
          ),
          suffixIcon: Icon(
            Icons.filter_alt_outlined,
            size: 30,
            color: Colors.brown.shade200,
          ),
        ),
      ),
    );
  }
}
