import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digifidelidade/app/shared/models/cartao_model.dart';
import 'package:digifidelidade/app/shared/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'tab_home_controller.g.dart';

class TabHomeController = _TabHomeControllerBase with _$TabHomeController;

abstract class _TabHomeControllerBase with Store {
  FirestoreService firestoreService = Modular.get();
  FirebaseAuth auth = Modular.get();
  @observable
  ObservableList<CartaoModel> cartoes = ObservableList();

  @action
  loadCartoesUsuarioLogado() async {
    String uid = (await auth.currentUser()).uid;
  }

  @action
  loadTodos() async {
    List<DocumentSnapshot> documentos =
        await this.firestoreService.getCartoes();
    this.cartoes = documentos
        .map((cartao) => CartaoModel.fromFirebaseDocument(cartao))
        .toList()
        .asObservable();
  }

  @action
  loadExternos() async {
    String uid = (await auth.currentUser()).uid;
  }
}
