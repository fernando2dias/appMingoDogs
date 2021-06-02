import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mingo_2/services/auth_service.dart';

class AutenticacaoController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var titulo = 'Bem vindo!'.obs;
  var botaoPrincipal = 'Entrar'.obs;
  var appBarButton = 'Cadastre-se'.obs;
  var isLogin = true.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogin, (visible) {
      titulo.value = visible ? 'Bem vindo' : 'Crie sua conta';
      botaoPrincipal.value = visible ? 'Entrar' : 'Registre-se';
      appBarButton.value = visible ? 'Cadastre-se' : 'Login';
      formKey.currentState.reset();
    });
  }

  login() {
    AuthService.to.login(email.text, senha.text);
  }

  registrar() {
    AuthService.to.createUser(email.text, senha.text);
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
