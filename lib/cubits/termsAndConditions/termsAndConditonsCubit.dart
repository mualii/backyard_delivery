import 'package:backyard_delivery/cubits/termsAndConditions/termsAndConditonsState.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditonsCubit extends Cubit<TermsAndConditonsState> {
  TermsAndConditonsCubit() : super(TermsAndConditonsInitial());

  getTerms(BuildContext context) {
    emit(TermsAndConditonsLoading());

    try {
      DioHelper.getData(
              endpoint: "/api/terms", setParamars: {}, context: context)
          .then((respone) {
        emit(TermsAndConditonsLoaded(respone));
      });
    } catch (e) {
      print(e.toString());
      emit(TermsAndConditonsError());
    }
  }
}
