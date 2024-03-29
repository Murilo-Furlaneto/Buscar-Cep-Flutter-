import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = TextEditingController();
  late String resultado = '';

  _consultaCep() async {
    String cep = txtcep.text;

    String url = 'https://viacep.com.br/ws/$cep/json/';

    http.Response response;
    response = await http.get((Uri.parse(url)));

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno['logradouro'];
    String cidade = retorno['localidade'];
    String bairro = retorno['bairro'];
    String uf = retorno['uf'];

    setState(() {
      //atualiza os valores da variavel resultado
      resultado = '$logradouro, $cidade,  $bairro, $uf';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        title: const Text('Consultando CEP '),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                alignment: Alignment.topCenter,
                child: Image.asset('assets/cep.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Digite o CEP ex: 1833400 ',
                  ),
                  style: const TextStyle(fontSize: 20),
                  controller: txtcep,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Center(
                    child: Text('Resultado: $resultado',
                        style: const TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: _consultaCep,
                    child: const Text('Consultar',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(primary: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
