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
  var _icon = AssetImage("assets/icone.png");

  _retornoWeb() async {
    String cepUser = _cepUser.text;
    String url = "https://viacep.com.br/ws/${cepUser}/json/";
    http.Response response;
    response = await http.get(url);
    //cepUser = response.body;
    //transformando objeto JSON em MAP
    Map<String, dynamic> retorno = json.decode(response.body);
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];

    setState(() {
      _resultado =
          "LOGRADOURO:  ${logradouro}\n\nBAIRRO:${bairro} \n\nLOCALIDADE:  ${localidade}\n\nUF: ${uf}\n\nDDD: ${ddd}";
      //imagem vazia png 100%
      _icon = AssetImage("assets/vazio.png");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(30),
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  height: 200,
                  width: 600,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              _resultado,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.all(25),
                              child: Container(
                                child: Image(
                                  image: this._icon,
                                  height: 100,
                                  width: 120,
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _cepUser,
                decoration: InputDecoration(hintText: "Digite o CEP"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  child: Text(
                    "BUSCAR",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[500],
                  onPressed: _retornoWeb),
            )
          ],
        ),
      )),
    ));
  }
}
