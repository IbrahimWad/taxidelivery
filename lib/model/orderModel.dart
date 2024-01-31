// ignore_for_file: unnecessary_null_comparison

class OrderModel {
  late String phone, payment;
  late double longitude, latitude, mylongitude, mylatitude, salary;

  OrderModel({
    required this.salary,
    required this.latitude,
    required this.longitude,
    required this.mylatitude,
    required this.mylongitude,
    required this.phone,
    required this.payment,
  });

  OrderModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    phone = map['phone'];
    salary = double.parse(map['salary'].toString());
    longitude = double.parse(map['longitude'].toString());
    latitude = double.parse(map['latitude'].toString());
    mylatitude = double.parse(map['mylatitude'].toString());
    mylongitude = double.parse(map['mylongitude'].toString());
    phone = map['payment'];
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'salary': salary.toString(),
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
      'mylatitude': mylatitude.toString(),
      'mylongitude': mylongitude.toString(),
      'payment': payment,
    };
  }
}
