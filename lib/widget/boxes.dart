import 'package:hive/hive.dart';
import 'package:weather_api_indonesia/model/user_model.dart';

class Boxes {
  static Box<User> getUser() => Hive.box<User>('users');
}
