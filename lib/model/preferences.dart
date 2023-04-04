import 'package:rs_libras/model/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> login(Client client) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('clientId', client.id!);
    prefs.setString('clientPhotoPath', client.photoPath);
    prefs.setString('clientName', client.name);
    prefs.setString('clientLastName', client.lastName);
    prefs.setString('clientEmail', client.email);
    prefs.setString('clientPassword', client.password);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('clientId');
    prefs.remove('clientPhotoPath');
    prefs.remove('clientName');
    prefs.remove('clientLastName');
    prefs.remove('clientEmail');
    prefs.remove('clientPassword');
  }

  static Future<Client?> getClient() async {
    final prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getInt('clientId');
    final clientPhotoPath = prefs.getString('clientPhotoPath');
    final clientName = prefs.getString('clientName');
    final clientLastName = prefs.getString('clientLastName');
    final clientEmail = prefs.getString('clientEmail');
    final clientPassword = prefs.getString('clientPassword');

    if (clientId != null &&
        clientPhotoPath != null &&
        clientName != null &&
        clientLastName != null &&
        clientEmail != null &&
        clientPassword != null) {
      return Client(
          id: clientId,
          photoPath: clientPhotoPath,
          name: clientName,
          lastName: clientLastName,
          email: clientEmail,
          password: clientPassword);
    } else {
      return null;
    }
  }
}
