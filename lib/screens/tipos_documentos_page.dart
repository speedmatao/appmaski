import 'package:flutter/material.dart';
import 'package:webmaskitchen/screens/documento_page.dart';

import '../api/api.dart';
import '../share_prefers/preferencias_usuario.dart';
import '../theme/light_colors.dart';
import '../widgets/info_top.dart';
import '../widgets/spiner_loading.dart';
import 'dart:html' as html;

class TipoDocumentosPage extends StatefulWidget {
  const TipoDocumentosPage({
    Key? key,
    this.razonSocial,
    this.idEmpleado,
  }) : super(key: key);

  final razonSocial;
  final idEmpleado;

  static const String routeName = 'tipo_documentos';

  @override
  State<TipoDocumentosPage> createState() => _TipoDocumentosPageState();
}

class _TipoDocumentosPageState extends State<TipoDocumentosPage> {
  bool inload = false;
  final prefs = PreferenciasUsuario();

  List<String> tipoDocumentos = ["PEDIDOS", "ALBARANES", "FACTURAS"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors().kLavender,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            InfoTop(
              redondo: false,
              inload: inload,
              texto: widget.razonSocial,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: inload
                      ? [const Center(child: Center(child: SpinnerPage()))]
                      : tarjetasDocumentos(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> tarjetasDocumentos() {
    List<Widget> respuesta = [];
    String tipoDocLetra = "";
    for (String tipo in tipoDocumentos) {
      respuesta.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          splashColor: LightColors().kLightGreen,
          onTap: () {
            if (tipo == "PEDIDOS") {
              tipoDocLetra = "P";
            } else if (tipo == "ALBARANES") {
              tipoDocLetra = "A";
            } else if (tipo == "FACTURAS") {
              tipoDocLetra = "F";
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Documentopage(
                    tipodoc: tipoDocLetra,
                    idEmpleado: widget.idEmpleado,
                    nombredocu: tipo),
              ),
            );
          },
          child: Ink(
            width: 270,
            height: 220,
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              color: LightColors().kGreen,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "VER $tipo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: LightColors().kLavender,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
      respuesta.add(const SizedBox(height: 10));
    }
    return respuesta;
  }
}
