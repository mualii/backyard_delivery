import 'package:backyard_delivery/cubits/termsAndConditions/termsAndConditonsCubit.dart';
import 'package:backyard_delivery/cubits/termsAndConditions/termsAndConditonsState.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffB09B87)));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffB09B87),
        appBar: customisedAppBar(context, true, true, 'Terms and Conditions'),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: BlocConsumer<TermsAndConditonsCubit, TermsAndConditonsState>(
            listener: (context, state) {},
            builder: (context, state) => state is TermsAndConditonsLoaded
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.03.sh, horizontal: 0.03.sw),
                      child: Center(
                        child: Html(
                          data: state.terms!,
                        ),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
