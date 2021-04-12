import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cepUser = TextEditingController();
  String _resultado = "";
  _retornoWeb() async {
    String cepUser = _cepUser.text;
    String url = "https://viacep.com.br/ws/${cepUser}/json/";
    http.Response response;
    response = await http.get(url);
    cepUser = response.body;
    //transformando objeto JSON em MAP
    Map<String, dynamic> retorno = json.decode(response.body);
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];
    String logradouro = retorno["logradouro"];

    setState(() {
      _resultado =
          "LOGRADOURO: ${logradouro} LOCALIDADE: ${localidade}  UF:${uf}  DDD:${ddd}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      height: 120,
                      width: 300,
                      color: Colors.white,
                      child: Text(_resultado)),
                ),
                TextField(
                  controller: _cepUser,
                ),
                RaisedButton(onPressed: _retornoWeb)
              ],
            ),
          )),
        ));
  }
}
