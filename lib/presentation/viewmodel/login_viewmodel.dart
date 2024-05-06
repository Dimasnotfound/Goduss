import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  LoginViewModel({required this.userRepository});

  Future<UserModel?> loginUser(String username, String password) async {
    return await userRepository.getUserByUsernameAndPassword(
        username, password);
  }
}
