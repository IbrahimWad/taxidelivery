// ignore_for_file: unnecessary_null_comparison

class UserModel {
  late String phone, otp;

  UserModel({required this.otp, required this.phone});

  UserModel.fromeJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    phone = map['phone'];
    otp = map['otp'];
  }

  toJson() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }
}
