import 'package:http/http.dart' as http;
import 'package:taxidelivery/model/AuthModel.dart';
import '../../view/widget/constant/URL.dart';

class LoginService {
  Login(UserModel userModel) async {
    final response = await http.post(
      Uri.parse(loginURL),
      body: userModel.toJson(),
    );
    return response;
  }
}
