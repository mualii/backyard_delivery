import 'dart:async';

import 'package:backyard_delivery/cubits/notification/notification_cubit.dart';
import 'package:backyard_delivery/cubits/notification/notification_state.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class NotificationsScreen extends StatelessWidget {
  int page = 1;

  loadMoredata(BuildContext context) {
    if (NotificationCubit.get(context).welcome!.nextPageUrl != null) {
      page++;
      NotificationCubit.get(context).loadMoreData(context, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffB09B87)));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          backgroundColor: Color(0xffB09B87),
          appBar: customisedAppBar(context, false),
          body: Stack(
            children: [
              Container(
                height: 0.1.sh,
                width: double.infinity,
                color: Color(0xffB09B87),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                  child: state is NotificationLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : NotificationCubit.get(context).data!.isEmpty
                          ? Center(
                              child: Text(
                                "You have no notification",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Color(0xff80392C),
                                ),
                              ),
                            )
                          : Container(
                              height: double.infinity,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: LazyLoadScrollView(
                                      onEndOfPage: () => loadMoredata(context),
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          page = 1;
                                          NotificationCubit.get(context)
                                              .getNotification(context);
                                        },
                                        child: ListView.separated(
                                            physics: const BouncingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            itemBuilder: (context, index) => NotificationCubit.get(context)
                                                            .data![index]
                                                            .data!
                                                            .message!
                                                            .en
                                                            .toString() ==
                                                        "Your order is on the way to you" ||
                                                    NotificationCubit.get(context)
                                                            .data![index]
                                                            .data!
                                                            .message!
                                                            .en
                                                            .toString() ==
                                                        "Order created" ||
                                                    NotificationCubit.get(context)
                                                            .data![index]
                                                            .data!
                                                            .message!
                                                            .en
                                                            .toString() ==
                                                        "The order is pending confirmation"
                                                ? Container()
                                                : ListTile(
                                                    // trailing: IconButton(icon:Icon(Icons.delete),onPressed: (){
                                                    //   DioHelper.deleteDataEither(endPoint: "/api/notifications/delete/${}",formDataInput: {});
                                                    // },),
                                                    leading: Icon(
                                                      FontAwesomeIcons
                                                          .solidDotCircle,
                                                      color: Colors.orange,
                                                    ),
                                                    title: Text(NotificationCubit
                                                                    .get(
                                                                        context)
                                                                .data![index]
                                                                .data!
                                                                .message!
                                                                .en
                                                                .toString() ==
                                                            "Your order is ready for delivery"
                                                        ? "You recived a delivery request"
                                                            .tr()
                                                        : LocalStorage.getData(
                                                                    key:
                                                                        "Lang") ==
                                                                "en"
                                                            ? NotificationCubit
                                                                    .get(
                                                                        context)
                                                                .data![index]
                                                                .data!
                                                                .message!
                                                                .en
                                                                .toString()
                                                            : NotificationCubit
                                                                    .get(
                                                                        context)
                                                                .data![index]
                                                                .data!
                                                                .message!
                                                                .ar
                                                                .toString()),
                                                    subtitle: Directionality(
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Order number : ${NotificationCubit.get(context).data![index].data!.orderNumber.toString()}"),
                                                            Text(
                                                                "${NotificationCubit.get(context).data![index].createdAt.toString().substring(0, 16)}"),
                                                          ],
                                                        )),
                                                  ),
                                            separatorBuilder: (context, index) =>
                                                NotificationCubit.get(context).data![index].data!.message!.en.toString() == "Your order is on the way to you" ||
                                                        NotificationCubit.get(context)
                                                                .data![index]
                                                                .data!
                                                                .message!
                                                                .en
                                                                .toString() ==
                                                            "Order created" ||
                                                        NotificationCubit.get(context)
                                                                .data![index]
                                                                .data!
                                                                .message!
                                                                .en
                                                                .toString() ==
                                                            "The order is pending confirmation"
                                                    ? Container()
                                                    : Divider(),
                                            itemCount: NotificationCubit.get(context).data!.length),
                                      ),
                                    ),
                                  ),
                                  state is NotificationLoadingMoreState
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
