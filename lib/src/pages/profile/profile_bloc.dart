import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifmaacessivel/src/app/app_module.dart';
import 'package:ifmaacessivel/src/auth/auth.dart';
import 'package:ifmaacessivel/src/models/user.dart';
import 'package:ifmaacessivel/src/shared/validators/profile_validator.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BlocBase with ProfileValidator {
  final campusController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final addressController = BehaviorSubject<String>();
  final phoneController = BehaviorSubject<String>();
  final responsibleController = BehaviorSubject<String>();

  ProfileBloc() {
    campusController.sink.add(User.campus);
    emailController.sink.add(User.email);
    addressController.sink.add(User.address);
    phoneController.sink.add(User.phone);
    responsibleController.sink.add(User.responsible);
  }

  Stream<String> get outCampus =>
      campusController.stream.transform(inputValidator);

  Stream<String> get outEmail =>
      emailController.stream.transform(inputValidator);

  Stream<String> get outAddress =>
      addressController.stream.transform(inputValidator);

  Stream<String> get outPhone =>
      phoneController.stream.transform(inputValidator);

  Stream<String> get outResponsible =>
      responsibleController.stream.transform(inputValidator);

  Function(String) get changeCampus => campusController.sink.add;

  Function(String) get changeEmail => emailController.sink.add;

  Function(String) get changeAddress => addressController.sink.add;

  Function(String) get changePhone => phoneController.sink.add;

  Function(String) get changeResponsible => responsibleController.sink.add;

  bool submit() {
    Map<String, String> data = {
      'campus': campusController.value,
      'email': emailController.value,
      'endereco': addressController.value,
      'telefone': phoneController.value,
      'encarregado': responsibleController.value,
    };

    try {
      Firestore.instance
          .collection(AppModule.to.getDependency<Auth>().getUserId())
          .document("usuario")
          .setData(data)
          .whenComplete(() {
        return true;
      });
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    campusController.close();
    emailController.close();
    addressController.close();
    phoneController.close();
    responsibleController.close();
  }
}
