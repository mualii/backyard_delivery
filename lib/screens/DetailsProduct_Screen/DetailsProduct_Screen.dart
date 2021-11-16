import 'dart:async';

import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryCubit.dart';
import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryState.dart';
import 'package:backyard_delivery/models/availiableDelivery.dart';
import 'package:backyard_delivery/screens/delivery_screen/delivery_screen.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsProductScreen extends StatelessWidget {
  int? index,id;
  bool? delivery;
   getlocation (BuildContext context)async{
    print( AvailiableDeliveryCubit.get(context).result!.orderDeliveryDetail!.location!.latitude!);
  var place= await placemarkFromCoordinates(
        AvailiableDeliveryCubit.get(context).result!.orderDeliveryDetail!.location!.latitude!.toDouble(),        AvailiableDeliveryCubit.get(context).result!.orderDeliveryDetail!.location!.longitude!.toDouble(),
        localeIdentifier:LocalStorage.getData(key: "Lang"));
  String loc="+${place[0].administrativeArea} ${place[0].street}";
return loc;
  }
  Completer<GoogleMapController> _controller = Completer();
  DetailsProductScreen(this.index,this.id,[this.delivery]);
  @override
  Widget build(BuildContext context) {
    print(index.toString());
    print(id.toString());
    AvailiableDeliveryCubit.get(context).getDetails(context, id!);

    Set<Marker> _createMarker(double latitude, double longitude) {
      return {
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: "marker 1",
            // snippet: office.address,
          ),
        ),
      };
    }
    return Scaffold(
      backgroundColor: Color(0xffB09B87),
      appBar: customisedAppBar(context, true),
      body: BlocConsumer<AvailiableDeliveryCubit,AvailibaleDeliveryState>(
    listener: (context,state){
      if(state is DetailsLoadedState){
       print( state.orders!.orderDeliveryDetail!.location!.latitude!.toDouble());
        print(state.orders!.orderDeliveryDetail!.location!.longitude!);}
    },
        builder:(contxt,state){
          return state is DetailsLoadedState? SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.03.sh, horizontal: 0.03.sw),
                  child: Text(
                    'Delivery details'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 70.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff80392C)),
                  ),
                ),
                Container(
                  height: .4.sh,
                  width: 1.sw,
                  child: GoogleMap(
                    markers:_createMarker(state.orders!.orderDeliveryDetail!.location!.latitude!, state.orders!.orderDeliveryDetail!.location!.longitude!) ,
onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          },

                    initialCameraPosition: CameraPosition(

                    target: LatLng(state.orders!.orderDeliveryDetail!.location!.latitude!.toDouble(),state.orders!.orderDeliveryDetail!.location!.longitude!.toDouble()),
                    zoom: 13,
                  ),)
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.03.sh, horizontal: 0.03.sw),
                  child: FutureBuilder(
                    future:getlocation(context) ,
                    builder: (context,snapshot)=>
                        snapshot.connectionState==ConnectionState.waiting?
                            Center(child: CircularProgressIndicator(),):
                        Container(
                      width: 0.4.sw,
                      child: Text(
                        snapshot.data.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' phone : '.tr(),
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                      ),

                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        state.orders!.orderDeliveryDetail!.phone.toString(),
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 50.sp, color: Color(0xffB9B9B9)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.01.sh, horizontal: 0.03.sw),
                  child: Text(
                    'Delivery contents'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff80392C)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  color: Color(0xffF6F6F6),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.orders!.orderLine!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           Text("${state.orders!.orderLine![index].name.toString()}"),
                            Text(" X "),
                            Text(state.orders!.orderLine![index].qty.toString()),
                            Expanded(
                              child: Text(

                                state.orders!.orderLine![index].total.toString(),
                                style: TextStyle(fontWeight: FontWeight.w700),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Text(
                    'Account information'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff80392C)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: Colors.red,
                      ),
                      Container(
                        width: 700.w,
                        height: 280.h,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          elevation: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' Total : '.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Color(0xff80392C)),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    state.orders!.total.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Color(0xffB9B9B9)),
                                  ),


                                ],
                              ),
                              Text(
                                state.orders!.orderPayment!.type.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffB9B9B9)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100.w,
                        child: CircleAvatar(
                          radius: 110.r,
                          backgroundColor: Color(0xff80392C),
                          child: Center(
                            child: Container(
                              width: 180.w,
                              child: Text(
                                "SAR".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: Text(
                    'Additional Information'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff80392C)),
                  ),
                ),
                Text(
                  state.orders!.notes,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50.sp, color: Color(0xffB9B9B9)),
                ),
                SizedBox(///
                  height: 50.h,
                ),
                InkWell(
                  onTap: () {
                    DioHelper.postData(endpoint: "/api/driver/delivery/finalize/${id}", formData: {"status":8},context: context).then((value) {
                      if(value =="1") {
                        Fluttertoast.showToast(msg: "Deliverd".tr());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DeliveryScreen()));
                      }  else
                        print("error");
                    });

                  },
                  child:delivery==null? Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffB09B87),
                      ),
                      height: .076.sh,
                      width: .65.sw,
                      child: Center(
                          child: Text(
                        'Deliverd'.tr(),
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ):Container(),
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ): Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),child: Center(child: CircularProgressIndicator()));},
      ),
    );
  }
}
