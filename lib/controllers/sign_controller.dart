import 'package:mysignal/models/sign_model.dart';

class SignController {
  final List<SignModel> _signs = mainSigns;

  List<SignModel> getSigns() {
    return _signs;
  }

  SignModel getSignById(int id) {
    return _signs.firstWhere((sign) => sign.id == id);
  }
}
