import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados antes de Calcular!";

  void _resetarDados() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe os dados antes de Calcular!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      double imc = peso / (altura * altura);

      if (imc < 16) {
        _infoText = "Magreza Grave (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 16 && imc < 17) {
        _infoText = "Magreza Moderada (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 17 && imc < 18) {
        _infoText = "Magreza Leve (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18 && imc < 25) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Obesidade Grau II, Severa(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText =
            "Obesidade Grau III, Mórbida(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(168, 53, 86, 10),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarDados,
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(222, 222, 222, 1),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 125,
                    color: Color.fromRGBO(168, 53, 86, 10),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Informe o Peso em Kg:",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(168, 53, 86, 10),
                            fontSize: 22.0),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(1686, 53, 86, 10),
                          fontSize: 22.0),
                      controller: pesoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe o seu Peso!";
                        }
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Informe a Altura em Cm:",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(168, 53, 86, 10),
                            fontSize: 22.0),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(1686, 53, 86, 10),
                          fontSize: 22.0),
                      controller: alturaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe a sua Altura!";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calcularIMC();
                          }
                        },
                        child: Text(
                          "Calcular IMC",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Color.fromRGBO(168, 53, 86, 10),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(168, 53, 86, 10), fontSize: 22.0),
                  ),
                ],
              ),
            )));
  }
}
