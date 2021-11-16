
import 'package:backyard_delivery/models/notification_model.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInital());
//hi
  static NotificationCubit get(context) => BlocProvider.of(context);
  List<Datum>? data;
  Welcome? welcome;
  void getNotification(BuildContext context) async {

    data=[];
    emit(NotificationLoadingState());
    var respone = await DioHelper.getData(
        endpoint: "/api/notifications",
        setParamars: {"page": "1"}, context: context,
        );
    if (respone is !String) {
      emit(NotificationSucsessState());
  welcome=Welcome.fromJson(respone);
      data! .addAll( welcome!.data!);
    } else if (respone is String) {
      emit(NotificationFailedState());
      print("fail");
    }
  }
  void loadMoreData(BuildContext context,int page) async {
    emit(NotificationLoadingMoreState());
    var respone = await DioHelper.getData(
      endpoint: "/api/notifications",
      setParamars: {"page": "${page.toString()}"}, context: context,
    );
    if (respone is !String) {
      emit(NotificationSucsessState());
      welcome=Welcome.fromJson(respone);
      data! .addAll( welcome!.data!);
    } else if (respone is String) {
      emit(NotificationFailedState());
      print("fail");
    }
  }

}
