
import 'package:recipe/feature/auth/data/model/user_model.dart';

abstract class LocalDataRepo {
  Future<void> addUser(UserModel user);
}