import 'package:flutter/material.dart';
import 'package:webmaskitchen/models/documentos.dart';
import 'package:webmaskitchen/models/lineas.dart';

import '../api/api.dart';
import '../share_prefers/preferencias_usuario.dart';
import '../theme/light_colors.dart';
import '../widgets/info_top.dart';
import '../widgets/spiner_loading.dart';
import 'dart:html' as html;

class LineasPage extends StatefulWidget {
  const LineasPage({
    Key? key,
    this.tipodoc,
    this.documento,
  }) : super(key: key);

  final String? tipodoc;
  final Documento? documento;

  static const String routeName = 'lineas';

  @override
  State<LineasPage> createState() => _LineasPageState();
}

class _LineasPageState extends State<LineasPage> {
  bool inload = false;
  final prefs = PreferenciasUsuario();
  List<Linea> lineaLista = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Linea>> fetchLineas() async {
    List<Linea> lineaList = [];
    var respuesta = await getLineasDoc(widget.tipodoc!, widget.documento!.id);
    for (var apartado in respuesta) {
      lineaList.add(Linea.fromJson(apartado));
    }
    return lineaList;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController controllerOne = ScrollController();
    /* fetchDocumentos().then((List<Documento> documentos) {
      documentoLista = documentos;
    }).catchError((error) {
      // Maneja cualquier error que ocurra durante la obtención de los documentos
    });*/
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 0, 0),
          child: Container(
            height: 80,
            width: 110,
            child: FloatingActionButton(
                backgroundColor: LightColors().kRojo,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Salir",
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ),
      ),
      backgroundColor: LightColors().kLavender,
      body: SafeArea(
        child: Scrollbar(
          controller: controllerOne,
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView(
            controller: controllerOne,
            children: <Widget>[
              InfoTop(
                redondo: false,
                inload: inload,
                texto: "Documento  ${widget.documento!.documento}",
              ),
              Center(
                child: FutureBuilder<List<Linea>>(
                  future: fetchLineas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Mientras se está obteniendo los documentos
                      return const SpinnerPage();
                    } else if (snapshot.hasError) {
                      // Si ocurre un error durante la obtención de los documentos
                      return const Text('Error al obtener los documentos');
                    } else {
                      // Cuando se han obtenido los documentos correctamente
                      lineaLista = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            horizontalMargin: 10,
                            showBottomBorder: true,
                            headingRowHeight: 40,
                            dataRowHeight: 56,
                            columnSpacing: 60,
                            border: const TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.black54,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.none,
                                width: 1.0,
                              ),
                            ),
                            headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            columns: const [
                              DataColumn(label: Text('Cod. Artículo')),
                              DataColumn(label: Text('Descripcion')),
                              DataColumn(label: Text('Cantidad')),
                              DataColumn(label: Text('Precio')),
                              DataColumn(label: Text('Importe')),
                            ],
                            rows: lineaLista.map((linea) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    linea.codigo,
                                  )),
                                  DataCell(Text(
                                    linea.descripcion,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Georgia"),
                                  )),
                                  DataCell(Text(linea.cantidad.toString())),
                                  DataCell(Text(
                                    "${linea.precio.toString()}€",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: LightColors().kBlue,
                                        fontFamily: "Georgia"),
                                  )),
                                  DataCell(Text(
                                    "${linea.importe.toString()}€",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: LightColors().kRojoF,
                                        fontFamily: "Georgia"),
                                  )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
