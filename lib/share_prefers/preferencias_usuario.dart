import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombreUsuario
  String get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  // GET y SET de la contraseña
  String get contrasenaUsuario {
    return _prefs.getString('contrasenaUsuario') ?? '';
  }

  set contrasenaUsuario(String value) {
    _prefs.setString('contrasenaUsuario', value);
  }

  // GET y SET de la ipEmpresa
  String get ipEmpresa {
    return _prefs.getString('ipEmpresa') ?? '';
  }

  set ipEmpresa(String value) {
    _prefs.setString('ipEmpresa', value);
  }

  // GET y SET de la idEmpresa
  String get idEmpresa {
    return _prefs.getString('idEmpresa') ?? '0';
  }

  set idEmpresa(String value) {
    _prefs.setString('idEmpresa', value);
  }

  // GET y SET de la idTrabajador
  String get idTrabajador {
    return _prefs.getString('idTrabajador') ?? '0';
  }

  set idTrabajador(String value) {
    _prefs.setString('idTrabajador', value);
  }

  // GET y SET del estado
  String get estado {
    return _prefs.getString('estado') ?? '';
  }

  set estado(String value) {
    _prefs.setString('estado', value);
  }

  // GET y SET de la hora de inicio

  // GET y SET del estado
  String get tema {
    return _prefs.getString('tema') ?? 'Claro';
  }

  set tema(String value) {
    _prefs.setString('tema', value);
  }
}
