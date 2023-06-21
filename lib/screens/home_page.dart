import 'package:flutter/material.dart';
import 'package:webmaskitchen/screens/tipos_documentos_page.dart';

import '../api/api.dart';
import '../share_prefers/preferencias_usuario.dart';
import '../theme/light_colors.dart';
import '../widgets/my_text_field.dart';
import '../widgets/spiner_loading.dart';
import '../widgets/top_container.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePage();
}

class _Controladores {
  TextEditingController? nombreUsuario, contrasenaUsuario, nombreEmpresa;
}

class _HomePage extends State<HomePage> {
  Color color = Colors.red;
  bool inload = false;
  bool condicion = false;

  final prefs = PreferenciasUsuario();

  String texto = "";

  final _Controladores _controladores = _Controladores();

  @override
  void initState() {
    super.initState();

    _controladores.nombreUsuario =
        TextEditingController(text: prefs.nombreUsuario);
    _controladores.nombreEmpresa = TextEditingController(text: "");
    _controladores.contrasenaUsuario =
        TextEditingController(text: prefs.contrasenaUsuario);
  }

  void controldeerrores() async {
    FocusManager.instance.primaryFocus?.unfocus();
    inload = true;
    setState(() {});
    List nombre = await recogeInfo();

    if (nombre.isEmpty) {
      texto = "Problemas con el server";
      prefs.estado = "Problemas con el server";
      color = Colors.red;
    } else if (nombre[0] == "Usuario o contraseña incorrectas") {
      texto = "Usuario o contraseña incorrectas";
      prefs.estado = "Usuario o contraseña incorrectas";
      color = Colors.red;
    } else if (nombre[0] == "vacio") {
      texto = "Hay campos vacíos";
      prefs.estado = "Hay campos vacíos en la configuración";
      color = Colors.red;
    } else {
      try {
        texto = "Hola, ${nombre[1]}";
        prefs.estado = "Con Conexión";
        color = Colors.green;
        prefs.idTrabajador = nombre[0];
        _controladores.nombreEmpresa!.text = nombre[1];
        condicion = true;
      } catch (e) {
        texto = "Error general";
        prefs.estado = "Error general";
        color = Colors.red;
      }
    }
    inload = false;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors().kLavender,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 100),
            Row(
              children: <Widget>[
                Expanded(child: Container()), // Margen izquierdo
                Expanded(
                  flex: 2,
                  child: TopContainer(
                    redondo: true,
                    height: 480,
                    padding: const EdgeInsets.fromLTRB(100, 100, 100, 40),
                    width: width,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                color: LightColors().kLavender,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyTextFieldController(
                              label: 'Nombre',
                              controller: _controladores.nombreUsuario,
                              onChanged: (value) {
                                prefs.nombreUsuario = value;
                              },
                            ),
                            const SizedBox(height: 35),
                            MyTextFieldController(
                              label: 'Contraseña',
                              controller: _controladores.contrasenaUsuario,
                              onChanged: (value) {
                                prefs.contrasenaUsuario = value;
                              },
                            ),
                            SizedBox(height: 35),

                            //
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                height: 80,
                                width: width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 25, 35, 0),
                                  child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: double.infinity,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      color: LightColors().kBlue,
                                      child: const Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      onLongPress: () {
                                        if (prefs.estado == "Con Conexión" &&
                                            prefs.contrasenaUsuario != "" &&
                                            prefs.nombreUsuario != "") {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TipoDocumentosPage(
                                                idEmpleado: prefs.idTrabajador,
                                                razonSocial: _controladores
                                                    .nombreEmpresa!.text,
                                              ),
                                            ),
                                          );
                                        } else {}
                                      },
                                      onPressed: () async {
                                        controldeerrores();
                                        /* const Center(
                        child: SpinnerPage());
                      await Future.delayed(Duration(milliseconds: 20));

                      if (prefs.estado == "Con Conexión" &&
                          prefs.contrasenaUsuario != "" &&
                          prefs.nombreUsuario != "") {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TipoDocumentosPage(
                              idEmpleado: prefs.idTrabajador,
                              razonSocial: _controladores.nombreEmpresa!.text,
                            ),
                          ),
                        );
                      }*/
                                      }),
                                ),
                              ),
                            ),

                            //
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()), // Margen derecho
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: !inload
                            ? Text(texto,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: color,
                                    fontSize: 25,
                                    fontFamily: 'Poppins'))
                            : const Center(
                                child: Center(
                                    child: SpinnerPage(
                                chiquito: true,
                              )))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (prefs.estado == "Con Conexión" &&
                      prefs.contrasenaUsuario != "" &&
                      prefs.nombreUsuario != "")
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 200,
                        width: 250,
                        padding: const EdgeInsets.fromLTRB(35, 25, 0, 0),
                        child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TipoDocumentosPage(
                                    idEmpleado: prefs.idTrabajador,
                                    razonSocial:
                                        _controladores.nombreEmpresa!.text,
                                  ),
                                ),
                              );
                            },
                            backgroundColor: LightColors().klilinfuerte2,
                            child: const Text(
                              "Ver Documentos",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
