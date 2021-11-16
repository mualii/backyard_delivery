
import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryState.dart';
import 'package:backyard_delivery/models/availiableDelivery.dart';
import 'package:backyard_delivery/models/orderDetails.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

class AvailiableDeliveryCubit extends Cubit<AvailibaleDeliveryState>{
  AvailiableDeliveryCubit() : super(AvailibaleDeliveryInitialState());
  static AvailiableDeliveryCubit get(context) => BlocProvider.of(context);
  OrderDetails? result;
  AvailaibleDelivery? availaibleDelivery ;
 List<Datum>?  availableList;
  getDeliveryList(BuildContext context){
    emit(AvailibaleDeliveryLoadingState());
    try{
      availableList=[];
    DioHelper.getData(endpoint: "/api/driver/delivery/active", context: context,setParamars: {"page":"1"}).then((respone){
availaibleDelivery=AvailaibleDelivery.fromJson(respone);

      availableList!.addAll(availaibleDelivery!.data!);
emit(AvailibaleDeliveryLoadedState());
    });}
    catch(e){ emit(AvailibaleDeliveryErrorState());}
  }

  loadMoreData(BuildContext context,int page){

    emit(AvailibaleDeliveryLoadingMoreState());
    try{

      DioHelper.getData(endpoint: "/api/driver/delivery/active", context: context,setParamars: {"page":"${page.toString()}"}).then((respone){
        availaibleDelivery=AvailaibleDelivery.fromJson(respone);

        availableList!.addAll(availaibleDelivery!.data!);
        emit(AvailibaleDeliveryLoadedState());
      });}
    catch(e){ emit(AvailibaleDeliveryErrorState());}
  }



  getDetails(BuildContext context,int id){
    emit(DetailsLoadingState());
    try{
      DioHelper.getData(endpoint: "/api/driver/delivery/details/${id}", setParamars: {}, context: context).then((reposne)async{
     result=   OrderDetails.fromJson(reposne);


        emit(DetailsLoadedState(result));
      });
    }
    catch(e){
      emit(DetailsErrorState());
    }
  }
}
