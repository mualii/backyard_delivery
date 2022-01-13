import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryCubit.dart';
import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryState.dart';
import 'package:backyard_delivery/models/availiableDelivery.dart';
import 'package:backyard_delivery/screens/DetailsProduct_Screen/DetailsProduct_Screen.dart';
import 'package:backyard_delivery/screens/delivery_screen/delivery_screen.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


class PreviousOrdersScreen extends StatelessWidget {
  int page=1;
loadMoredata(BuildContext context, DeliveryHistoryCubit deliveryCubit){
    if(deliveryCubit.availaibleDelivery!.nextPageUrl!=null){
       page++;
    deliveryCubit.loadMoreDate(context, page);
      }
  }
  @override
  Widget build(BuildContext context) {
    DeliveryHistoryCubit deliveryCubit = DeliveryHistoryCubit.get(context);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffB09B87)));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

      },
      child: BlocConsumer<DeliveryHistoryCubit, DeliveryHistoryState>(
        listener: (contex, state) {},
        builder: (contex, state) {
          return Scaffold(
            backgroundColor: Color(0xffB09B87),
            appBar: customisedAppBar(context, true, true, 'الطلبات السابقة'),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 0.01.sh),
                child: state is DeliveryHistoryLoading
                    ? Center(child: CircularProgressIndicator())
                    : deliveryCubit.availableList!.length == 0
                        ? Text("noOrders".tr(),  style: TextStyle(fontSize: 60.sp, color: Color(0xffB09B87)),)
                        :Column(
                          children: [
                            Expanded(
                              child: LazyLoadScrollView(


                  onEndOfPage:()=> loadMoredata(context,deliveryCubit),
                                child: RefreshIndicator(
                                  onRefresh: ()async{
                                    page=1;
                                    deliveryCubit.getHistory(context, page);
                                  },
                                  child: ListView.separated(         physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      itemBuilder: (context, index) => GestureDetector(
                                        onTap: ()=>navigateTo(context, DetailsProductScreen(index, deliveryCubit.availableList![index].id,true)),
                                        child: HasDeliveredBuild(
                                            deliveryCubit.availableList![index]),
                                      ),
                                      separatorBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(),
                                      ),
                                      itemCount: deliveryCubit.availableList!.length,
                                    ),
                                ),
                              ),
                            ),
                            state is DeliveryHistoryLoadingMore?
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),):Container()
                          ],
                        ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget HasDeliveredBuild(Datum item) {
    return Center(
        child: Container(
      height: .13.sh,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffB09B87), width: .5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Order nummber'.tr(),
                    style: TextStyle(color: Color(0xff80392C), fontSize: 55.sp),
                  ),

                  Text(
                    item.orderNumber.toString(),
                    style: TextStyle(fontSize: 55.sp, color: Colors.grey[400]),
                  ),
                  Text(
                    item.orderStatus!.name.toString(),
                    style: TextStyle(fontSize: 55.sp, color: Color(0xff80392C)),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ' Client name : '.tr(),
                    style: TextStyle(color: Color(0xff80392C), fontSize: 55.sp),
                  ),
                  Text(
                    item.orderDeliveryDetail!.name.toString(),
                    style: TextStyle(fontSize: 55.sp, color: Colors.grey[400]),
                  ),
                  Text(
                    item.orderDeliveryDetail!.time.toString().substring(9, 17),
                    style: TextStyle(fontSize: 50.sp, color: Colors.grey[400]),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
