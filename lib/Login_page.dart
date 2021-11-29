// ログイン画面用Widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login_model.dart';
import 'chat_page.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginModel(),
        child: Builder(builder: (BuildContext context) {

          final model = Provider.of<LoginModel>(context);
          final UserState userState = Provider.of<UserState>(context);

          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // メールアドレス入力
                    TextFormField(
                      decoration: InputDecoration(labelText: 'メールアドレス'),
                      onChanged: model.setEmail,
                    ),
                    // パスワード入力
                    TextFormField(
                      decoration: InputDecoration(labelText: 'パスワード'),
                      obscureText: true,
                      onChanged: model.setPassword,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      // メッセージ表示
                      child: Text(model.infoText),
                    ),
                    Container(
                      width: double.infinity,
                      // ユーザー登録ボタン
                      child: ElevatedButton(
                        child: Text('ユーザー登録'),
                        onPressed: () async {
                          try {
                            model.auth();
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return ChatPage();
                              }),
                            );
                          } catch (e) {
                            // ユーザー登録に失敗した場合
                            model.message(e);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      // ログイン登録ボタン
                      child: OutlinedButton(
                        child: Text('ログイン'),
                        onPressed: () async {
                          try {
                            model.auth();

                            // ログインに成功した場合
                            // チャット画面に遷移＋ログイン画面を破棄
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return ChatPage();
                              }),
                            );
                          } catch (e) {
                            // ログインに失敗した場合
                            model.infoText = "ログインに失敗しました：${e.toString()}";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
    );
  }
}