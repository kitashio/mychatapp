import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class LoginModel with ChangeNotifier {

  final UserState userState = Provider.of<UserState>(context);

  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';

 void setEmail (String value) {
     email = value;
     notifyListeners();
 }

  void setPassword (String value) {
    password = value;
    notifyListeners();
  }

  void auth () async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // ユーザー情報を更新
    userState.setUser(result.user);
  }

void message (String value){
  infoText = "登録に失敗しました：${toString()}";
  notifyListeners();
}

}// LoginModel