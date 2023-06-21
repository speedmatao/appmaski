import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../share_prefers/preferencias_usuario.dart';

Future<List> recogeInfo() async {
  final prefs = PreferenciasUsuario();
  //peticion post
  if (prefs.contrasenaUsuario == "" || prefs.nombreUsuario == "") {
    return ["vacio"];
  } else {
    Uri url = Uri.parse(
        'http://${prefs.ipEmpresa}/wsplus/GetDatosCliente'); //${prefs.ipEmpresa}
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded",
    };
    Object? body = {
      "login": prefs.nombreUsuario,
      "pass": prefs.contrasenaUsuario,
      "empresa": prefs.idEmpresa,
    };
    try {
      Response response = await post(url, headers: headers, body: body);
      var respuesta = response.body;
      var respuesta1 = respuesta.split("|");
      return respuesta1;
    } catch (e) {
      return [];
    }
  }
}

Future<List> getDocumentosCli(String tipoDoc, String idEmpleado) async {
  final prefs = PreferenciasUsuario();
  //peticion post
  if (prefs.contrasenaUsuario == "" || prefs.nombreUsuario == "") {
    return ["vacio"];
  } else {
    Uri url = Uri.parse('http://${prefs.ipEmpresa}/wsplus/GetDocumentosCli');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Object? body = {
      "empresa": prefs.idEmpresa,
      "tipodoc": tipoDoc,
      "codCliente": idEmpleado,
      "filtro": "",
    };
    try {
      Response response = await post(url, headers: headers, body: body);
      if (response.body != "") {
        String respuestabruta = response.body;
        List respuesta = jsonDecode(respuestabruta);
        if (respuesta[0]["alignment"] != null) {
          return []; //para comprobar que ha dado algún resultado, si viene vacío tiramos del return
        }
        return respuesta;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());

      return [];
    }
  }
}

Future<List> getLineasDoc(String tipoDoc, int idDocumento) async {
  final prefs = PreferenciasUsuario();
  //peticion post
  if (prefs.contrasenaUsuario == "" || prefs.nombreUsuario == "") {
    return ["vacio"];
  } else {
    Uri url = Uri.parse('http://${prefs.ipEmpresa}/wsplus/GetLineasDoc');
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Object? body = {
      "empresa": prefs.idEmpresa,
      "tipodoc": tipoDoc,
      "idDocumento": idDocumento.toString(),
    };
    try {
      Response response = await post(url, headers: headers, body: body);
      if (response.body != "") {
        String respuestabruta = response.body;
        List respuesta = jsonDecode(respuestabruta);
        if (respuesta[0]["alignment"] != null) {
          return []; //para comprobar que ha dado algún resultado, si viene vacío tiramos del return
        }
        return respuesta;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());

      return [];
    }
  }
}
