import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryCubit.dart';
import 'package:backyard_delivery/cubits/availableDelivery/availiableDeliveryState.dart';

import 'package:backyard_delivery/screens/DetailsProduct_Screen/DetailsProduct_Screen.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class DeliveryScreen extends StatelessWidget {
  int page = 1;

  loadMoredata(BuildContext context, AvailiableDeliveryCubit deliveryCubit) {
    if (deliveryCubit.availaibleDelivery!.nextPageUrl != null) {
      page++;
      deliveryCubit.loadMoreData(context, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    AvailiableDeliveryCubit deliveryCubit =
        AvailiableDeliveryCubit.get(context);

    return BlocConsumer<AvailiableDeliveryCubit, AvailibaleDeliveryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              backgroundColor: Color(0xffB09B87),
              appBar: customisedAppBar(context, false),
              body: deliveryCubit.availableList == null
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.03.sh, horizontal: 0.03.sw),
                        child: state is AvailibaleDeliveryLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : AvailiableDeliveryCubit.get(context)
                                        .availableList!
                                        .length ==
                                    0
                                ? Center(
                                    child: Text(
                                    "No active orders".tr(),
                                    style: TextStyle(
                                        fontSize: 60.sp,
                                        color: Color(0xffB09B87)),
                                  ))
                                : Column(
                                    children: [
                                      Expanded(
                                        child: LazyLoadScrollView(
                                          onEndOfPage: ()=>loadMoredata(
                                              context, deliveryCubit),
                                          child: RefreshIndicator(
                                            onRefresh: () async {
                                              page = 1;
                                              deliveryCubit
                                                  .getDeliveryList(context);
                                            },
                                            child: ListView.separated(
                                              // primary: false,
                                              physics: const BouncingScrollPhysics(
                                                  parent:
                                                      AlwaysScrollableScrollPhysics()),
                                              itemBuilder: (context, index) =>
                                                  InDeliverdBuilder(
                                                      context: context,
                                                      index: index,
                                                      id: deliveryCubit
                                                          .availableList![index]
                                                          .id!
                                                          .toInt()),
                                              separatorBuilder:
                                                  (context, index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Divider(),
                                              ),
                                              itemCount:
                                                  AvailiableDeliveryCubit.get(
                                                          context)
                                                      .availableList!
                                                      .length,
                                            ),
                                          ),
                                        ),
                                      ),
                                      state is AvailibaleDeliveryLoadingMoreState
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                      ),
                    )),
        );
      },
    );
  }

  Widget HasDeliveredBuild() {
    return Center(
        child: Container(
      height: .12.sh,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffB09B87), width: .5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تم التوصيل',
                    style: TextStyle(fontSize: 55.sp, color: Color(0xff80392C)),
                  ),
                  Opacity(
                    opacity: .4,
                    child: Text(
                      '05 : 30 PM',
                      style:
                          TextStyle(fontSize: 50.sp, color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Opacity(
                opacity: .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '59585',
                          style: TextStyle(
                              fontSize: 55.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          '    :  طلب رقم     ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 55.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' عبدالله فرج',
                          style: TextStyle(
                              fontSize: 55.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          ' :  إسم العميل    ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 55.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  InDeliverdBuilder(
      {required int index, required BuildContext context, required int id}) {
    print(id.toString());
    return GestureDetector(
      onTap: () {
        navigateTo(context, DetailsProductScreen(index, id));
      },
      child: Container(
        height: .167.sh,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffB09B87), width: .5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Order nummber'.tr(),
                      style:
                          TextStyle(color: Color(0xff80392C), fontSize: 55.sp),

                    ),
                    Text(
                      AvailiableDeliveryCubit.get(context)
                          .availableList![index]
                          .orderNumber
                          .toString(),
                      style:
                          TextStyle(fontSize: 55.sp, color: Colors.grey[400]),
                    ),
                  ],
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ' Client name : '.tr(),
                      style:
                          TextStyle(color: Color(0xff80392C), fontSize: 55.sp),
                    ),
                    Text(
                      AvailiableDeliveryCubit.get(context)
                          .availableList![index]
                          .orderDeliveryDetail!
                          .name
                          .toString(),
                      style:
                          TextStyle(fontSize: 55.sp, color: Colors.grey[400]),
                    ),
                  ],
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' phone : '.tr(),
                      style:
                          TextStyle(color: Color(0xff80392C), fontSize: 55.sp),
                    ),
                    Text(
                      AvailiableDeliveryCubit.get(context)
                          .availableList![index]
                          .orderDeliveryDetail!
                          .phone
                          .toString(),
                      style:
                          TextStyle(fontSize: 55.sp, color: Colors.grey[400]),
                    ),
                    Text(
                        "${AvailiableDeliveryCubit.get(context).availableList![index].orderDeliveryDetail!.time.toString().substring(0, 7)} ",
                        style: TextStyle(
                            fontSize: 50.sp, color: Colors.grey[400])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
