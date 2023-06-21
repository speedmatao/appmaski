import 'package:flutter/material.dart';
import 'package:webmaskitchen/models/documentos.dart';
import 'package:webmaskitchen/screens/lineas_page.dart';

import '../api/api.dart';
import '../share_prefers/preferencias_usuario.dart';
import '../theme/light_colors.dart';
import '../widgets/info_top.dart';
import '../widgets/spiner_loading.dart';

import 'package:universal_html/html.dart' as html;
import 'package:data_table_2/data_table_2.dart';

class Documentopage extends StatefulWidget {
  const Documentopage({
    Key? key,
    this.idEmpleado,
    this.tipodoc,
    this.nombredocu,
  }) : super(key: key);

  final String? tipodoc;
  final String? idEmpleado;
  final String? nombredocu;

  static const String routeName = 'documento';

  @override
  State<Documentopage> createState() => _DocumentopageState();
}

class _DocumentopageState extends State<Documentopage> {
  bool inload = false;
  final prefs = PreferenciasUsuario();
  List<Documento> documentoLista = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Documento>> fetchDocumentos() async {
    List<Documento> documentoList = [];
    var respuesta = await getDocumentosCli(widget.tipodoc!, widget.idEmpleado!);
    for (var apartado in respuesta) {
      documentoList.add(Documento.fromJson(apartado));
    }
    return documentoList;
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
                texto: "Listado de ${widget.nombredocu!}",
              ),
              Center(
                child: FutureBuilder<List<Documento>>(
                  future: fetchDocumentos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Mientras se está obteniendo los documentos
                      return const SpinnerPage();
                    } else if (snapshot.hasError) {
                      // Si ocurre un error durante la obtención de los documentos
                      return const Text('Error al obtener los documentos');
                    } else {
                      // Cuando se han obtenido los documentos correctamente
                      documentoLista = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              horizontalMargin: 10,
                              showBottomBorder: true,
                              headingRowHeight: 40,
                              dataRowHeight: 50,
                              columnSpacing: 50,
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
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text('Documento'),
                                ),
                                DataColumn(
                                  label: Text('Fecha'),
                                ),
                                DataColumn(
                                  label: Text('Importe'),
                                ),
                                DataColumn(
                                  label: Text('Estado'),
                                ),
                                DataColumn(
                                  label: Text('Ver líneas'),
                                ),
                              ],
                              rows: documentoLista.map((documento) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        documento.documento,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Georgia"),
                                      ),
                                    ),
                                    DataCell(
                                      Text(documento.fecha.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        "${documento.importe.toStringAsFixed(2)}€",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia",
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              150, // Establece un ancho máximo para la celda
                                        ),
                                        child: Text(
                                          documento.estado,
                                          style: TextStyle(
                                            color: LightColors().kBlue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Georgia",
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => LineasPage(
                                                documento: documento,
                                                tipodoc: widget.tipodoc!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Ver líneas'),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            )),
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
