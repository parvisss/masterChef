import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();

  //! Login
  Future login(String email, String password) async {
    try {
      final response = await dio.post(
        'http://recipe.flutterwithakmaljon.uz/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        print("Login success");

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            'userToken', response.data['data']['token']);

        return response.data;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  //! Register

  Future register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phone,
  ) async {
    try {
      final response = await dio.post(
        'http://recipe.flutterwithakmaljon.uz/api/register',
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        print('register success');
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            'userToken', response.data['data']['token']);

        return response.data;
      } else {
        print('erros ${response.statusCode}');
      }
    } catch (e) {
      print('error $e try ga kirmadi');
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userData = sharedPreferences.getString('userToken');
      if (userData == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }
}
