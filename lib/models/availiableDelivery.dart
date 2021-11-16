// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AvailaibleDelivery welcomeFromJson(String str) => AvailaibleDelivery.fromJson(json.decode(str));

String welcomeToJson(AvailaibleDelivery data) => json.encode(data.toJson());

class AvailaibleDelivery {
  AvailaibleDelivery({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int ?currentPage;
  List<Datum> ?data;
  String? firstPageUrl;
  int ?from;
  dynamic nextPageUrl;
  String ?path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory AvailaibleDelivery.fromJson(Map<String, dynamic> json) => AvailaibleDelivery(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
  };
}

class Datum {
  Datum({
    this.id,
    this.orderNumber,
    this.serviceRating,
    this.subTotal,
    this.deliveryCost,
    this.discount,
    this.total,
    this.notes,
    this.createdAt,
    this.orderDeliveryDetail,
    this.orderStatus,
  });

  int? id;
  int ?orderNumber;
  dynamic serviceRating;
  String? subTotal;
  String ?deliveryCost;
  dynamic discount;
  String ?total;
  String ?notes;
  DateTime? createdAt;
  OrderDeliveryDetail ?orderDeliveryDetail;
  OrderStatus? orderStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderNumber: json["order_number"],
    serviceRating: json["service_rating"],
    subTotal: json["sub_total"],
    deliveryCost: json["delivery_cost"],
    discount: json["discount"],
    total: json["total"],
    notes: json["notes"],
    createdAt: DateTime.parse(json["created_at"]),
    orderDeliveryDetail: OrderDeliveryDetail.fromJson(json["order_delivery_detail"]),
    orderStatus: OrderStatus.fromJson(json["order_status"]),
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
    "order_delivery_detail": orderDeliveryDetail!.toJson(),
    "order_status": orderStatus!.toJson(),
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
  String ?phone;
  String ?time;
  DateTime? date;
  dynamic driverFeed;
  String ? hints;
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

class OrderStatus {
  OrderStatus({
    this.id,
    this.name,
    this.message,
  });

  int? id;
  String? name;
  String? message;

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
