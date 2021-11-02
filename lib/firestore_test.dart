import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirestorePage extends StatefulWidget {
  @override
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {

  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 100, 32, 32),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text('コレクション＋ドキュメント作成'),
                onPressed: () {
                  // ドキュメント作成
                  try {
                  final FirebaseFirestore basestore = FirebaseFirestore.instance.collection('users') // コレクションID
                      .doc('id_abc') // ドキュメントID
                      .set({'name': '鈴木', 'age': 40}) as FirebaseFirestore;// データ

                  setState(() {
                    infoText = "登録OK";
                  });
                } catch (e) {
                // 登録に失敗した場合
                setState(() {
                infoText = "登録NG：${e.toString()}";
                });
                  }
                },
              ),
              const SizedBox(height: 8),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}