// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OrderDetails welcomeFromJson(String str) =>  OrderDetails.fromJson(json.decode(str));

String welcomeToJson( OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  OrderDetails({
    this.id,
    this.orderNumber,
    this.serviceRating,
    this.subTotal,
    this.deliveryCost,
    this.discount,
    this.total,
    this.notes,
    this.createdAt,
    this.orderStatus,
    this.orderPayment,
    this.orderLine,
    this.orderDeliveryDetail,
    this.orderStatusHistory,
  });

  int? id;
  int ?orderNumber;
  dynamic serviceRating;
  String ?subTotal;
  String? deliveryCost;
  dynamic discount;
  String ?total;
  dynamic notes;
  DateTime? createdAt;
  OrderStatus? orderStatus;
  OrderPayment? orderPayment;
  List<OrderLine>? orderLine;
  OrderDeliveryDetail? orderDeliveryDetail;
  List<OrderStatusHistory>? orderStatusHistory;

  factory  OrderDetails.fromJson(Map<String, dynamic> json) =>  OrderDetails(
    id: json["id"],
    orderNumber: json["order_number"],
    serviceRating: json["service_rating"],
    subTotal: json["sub_total"],
    deliveryCost: json["delivery_cost"],
    discount: json["discount"],
    total: json["total"],
    notes: json["notes"],
    createdAt: DateTime.parse(json["created_at"]),
    orderStatus: OrderStatus.fromJson(json["order_status"]),
    orderPayment: OrderPayment.fromJson(json["order_payment"]),
    orderLine: List<OrderLine>.from(json["order_line"].map((x) => OrderLine.fromJson(x))),
    orderDeliveryDetail: OrderDeliveryDetail.fromJson(json["order_delivery_detail"]),
    orderStatusHistory: List<OrderStatusHistory>.from(json["order_status_history"].map((x) => OrderStatusHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "service_rating": serviceRating,
    "sub_total": subTotal,
    "delivery_cost": deliveryCost,
    "discount": discount,
    "total": total,
    "notes": notes,
    "created_at": createdAt!.toIso8601String(),
    "order_status": orderStatus!.toJson(),
    "order_payment": orderPayment!.toJson(),
    "order_line": List<dynamic>.from(orderLine!.map((x) => x.toJson())),
    "order_delivery_detail": orderDeliveryDetail!.toJson(),
    "order_status_history": List<dynamic>.from(orderStatusHistory!.map((x) => x.toJson())),
  };
}

class OrderDeliveryDetail {
  OrderDeliveryDetail({
    this.name,
    this.phone,
    this.time,
    this.date,
    this.driverFeed,
    this.hints,
    this.location,
  });

  String? name;
  dynamic phone;
  String ?time;
  DateTime? date;
  dynamic driverFeed;
  dynamic hints;
  Location ?location;

  factory OrderDeliveryDetail.fromJson(Map<String, dynamic> json) => OrderDeliveryDetail(
    name: json["name"],
    phone: json["phone"],
    time: json["time"],
    date: DateTime.parse(json["date"]),
    driverFeed: json["driver_feed"],
    hints: json["hints"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "time": time,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "driver_feed": driverFeed,
    "hints": hints,
    "location": location!.toJson(),
  };
}

class Location {
  Location({
    this.longitude,
    this.latitude,
  });

  double? longitude;
  double ?latitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}

class OrderLine {
  OrderLine({
    this.image,
    this.option,
    this.extras,
    this.qty,
    this.total,
    this.name,
  });

  String ?image;
  dynamic option;
  List<dynamic>? extras;
  int ?qty;
  String ?total;
  String ?name;

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
    image: json["image"],
    option: json["option"],
    extras: List<dynamic>.from(json["extras"].map((x) => x)),
    qty: json["qty"],
    total: json["total"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "option": option,
    "extras": List<dynamic>.from(extras!.map((x) => x)),
    "qty": qty,
    "total": total,
    "name": name,
  };
}

class OrderPayment {
  OrderPayment({
    this.id,
    this.invoiceId,
    this.invoiceUrl,
    this.paymentId,
    this.type,
    this.method,
    this.paidAt,
    this.cardNumber,
  });

  String? id;
  dynamic invoiceId;
  dynamic invoiceUrl;
  dynamic paymentId;
  String ?type;
  dynamic method;
  dynamic paidAt;
  dynamic cardNumber;

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
    id: json["id"],
    invoiceId: json["invoiceId"],
    invoiceUrl: json["invoiceURL"],
    paymentId: json["paymentId"],
    type: json["type"],
    method: json["method"],
    paidAt: json["paid_at"],
    cardNumber: json["card_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoiceId": invoiceId,
    "invoiceURL": invoiceUrl,
    "paymentId": paymentId,
    "type": type,
    "method": method,
    "paid_at": paidAt,
    "card_number": cardNumber,
  };
}

class OrderStatus {
  OrderStatus({
    this.id,
    this.name,
    this.message,
  });

  int? id;
  String? name;
  String ?message;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    id: json["id"],
    name: json["name"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "message": message,
  };
}

class OrderStatusHistory {
  OrderStatusHistory({
    this.message,
    this.createdAt,
    this.orderStatus,
  });

  dynamic message;
  DateTime? createdAt;
  OrderStatus? orderStatus;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) => OrderStatusHistory(
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    orderStatus: OrderStatus.fromJson(json["order_status"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "created_at": createdAt!.toIso8601String(),
    "order_status": orderStatus!.toJson(),
  };
}
