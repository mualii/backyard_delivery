

import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryState.dart';
import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryState.dart';
import 'package:backyard_delivery/models/availiableDelivery.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryHistoryCubit extends Cubit<DeliveryHistoryState>{
  DeliveryHistoryCubit() : super(DeliveryHistoryInitail());


  static DeliveryHistoryCubit get(context)=>BlocProvider.of(context);




    int page=1;
    AvailaibleDelivery? availaibleDelivery ;
    List<Datum> ? availableList;
    getHistory(BuildContext context,int page){
      emit(DeliveryHistoryLoading());
      try{
        availableList=[];
        DioHelper.getData(endpoint: "/api/driver/delivery/history", context: context,setParamars: {"page":"${page.toString()}"}).then((respone){
          availaibleDelivery=AvailaibleDelivery.fromJson(respone);

          availableList!.addAll(availaibleDelivery!.data!);
          emit(DeliveryHistoryLoaded());
        });}
      catch(e){ emit(DeliveryHistoryError());}

  }
  loadMoreDate(BuildContext context,int page){

    try{
emit(DeliveryHistoryLoadingMore());
      DioHelper.getData(endpoint: "/api/driver/delivery/history", context: context,setParamars: {"page":"${page.toString()}"}).then((respone){
        availaibleDelivery=AvailaibleDelivery.fromJson(respone);

        availableList!.addAll(availaibleDelivery!.data!);
        emit(DeliveryHistoryLoaded());

      });}
    catch(e){ }

  }

  }
