import 'dart:math';

import 'package:flutter/material.dart';

class PPT extends StatefulWidget {
  const PPT({Key? key}) : super(key: key);

  @override
  State<PPT> createState() => _PPTState();
}

class _PPTState extends State<PPT> {
  String _imgUserPlayer = "imagens/indefinido.png";
  String _imgAppPlayer = "imagens/indefinido.png";

  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ['pedra', 'papel', 'tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }

  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
      case "tesoura":
        if (escolhaApp == "papel") {
          resultado = "user";
        } else if (escolhaApp == "pedra") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
    }

    setState(() {
      if (_userPoints == 15 || _appPoints == 15) {
        _userPoints = 0;
        _appPoints = 0;
        _tiePoints = 0;
        _borderUserColor = Colors.transparent;
        _borderAppColor = Colors.transparent;
      } else {
        if (resultado == "user") {
          _userPoints++;
          _borderUserColor = Colors.green;
          _borderAppColor = Colors.transparent;
        } else if (resultado == "app") {
          _appPoints++;
          _borderUserColor = Colors.transparent;
          _borderAppColor = Colors.green;
        } else {
          _tiePoints++;
          _borderUserColor = Colors.orange;
          _borderAppColor = Colors.orange;
        }
      }
    });
  }

  void _iniciaJogada(String opcao) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      _imgUserPlayer = "imagens/$opcao.png";
    });

    String escolhaApp = _obtemEscolhaApp();
    setState(() {
      _imgAppPlayer = "imagens/$escolhaApp.png";
    });

    _terminaJogada(opcao, escolhaApp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App - Pedra Papel Tesoura"),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "Disputa",
              style: TextStyle(fontSize: 26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: _borderUserColor, width: 4),
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Image.asset(
                  _imgUserPlayer,
                  height: 120,
                ),
              ),
              const Text('VS'),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: _borderAppColor, width: 4),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  child: Image.asset(_imgAppPlayer, height: 120))
            ],
          ),
          const Text('Placar', style: TextStyle(fontSize: 26)),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Você'),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(35),
                      child: Text('$_userPoints',
                          style: const TextStyle(fontSize: 26)),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text('Empate'),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(35),
                        child:
                            Text('$_tiePoints', style: TextStyle(fontSize: 26)))
                  ],
                ),
                Column(
                  children: [
                    const Text('App'),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(35),
                        child:
                            Text('$_appPoints', style: TextStyle(fontSize: 26)))
                  ],
                ),
              ],
            ),
          ),
          const Text('Opções', style: TextStyle(fontSize: 26)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _iniciaJogada("pedra"),
                child: Image.asset(
                  'imagens/pedra.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("papel"),
                child: Image.asset(
                  'imagens/papel.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("tesoura"),
                child: Image.asset(
                  'imagens/tesoura.png',
                  height: 90,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

void main() {
  runApp(PPT());
}
