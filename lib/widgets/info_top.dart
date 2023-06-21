import 'package:flutter/material.dart';
import 'package:webmaskitchen/widgets/spiner_loading.dart';
import 'package:webmaskitchen/widgets/top_container.dart';

import '../screens/home_page.dart';
import '../share_prefers/preferencias_usuario.dart';
import '../theme/light_colors.dart';

class InfoTop extends StatefulWidget {
  const InfoTop(
      {Key? key,
      this.inload,
      this.texto,
      this.sinDetalle,
      this.height,
      this.redondo})
      : super(key: key);

  final bool? inload;
  final String? texto;
  final bool? sinDetalle;
  final double? height;
  final bool? redondo;

  @override
  State<InfoTop> createState() => _InfoTopState();
}

class _InfoTopState extends State<InfoTop> {
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return TopContainer(
      redondo: widget.redondo,
      padding: const EdgeInsets.all(0),
      height: widget.height ?? 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.inload ?? false
                          ? <Widget>[
                              Center(
                                  child: SpinnerPage(
                                chiquito: true,
                                color: LightColors().kLavender,
                              ))
                            ]
                          : <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                  right: 50,
                                ),
                                child: Text(
                                  widget.texto ?? prefs.nombreUsuario,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors().kLavender,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              widget.sinDetalle == false ||
                                      widget.sinDetalle == null
                                  ? Text(
                                      prefs.estado,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: LightColors().kLavender,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Container(),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Colors.red, // Color de fondo rojo
                                      onPrimary:
                                          Colors.white, // Color de texto blanco
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal:
                                              24), // Espaciado interno del botón
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Lógica para realizar el formateo de valores y cerrar sesión
                                      // prefs.clear(); // Limpiar las preferencias guardadas
                                      prefs.nombreUsuario = '';
                                      prefs.contrasenaUsuario = '';
                                      prefs.estado = '';

                                      Navigator.pushReplacementNamed(
                                          context, HomePage.routeName);
                                    },
                                    child: const Text('Cerrar sesión'),
                                  ),
                                ),
                              )
                            ],
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
