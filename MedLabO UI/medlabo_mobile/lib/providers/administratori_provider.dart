import 'package:medlabo_mobile/models/administrator/administrator.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';

class AdministratoriProvider extends BaseProvider<Administrator> {
  AdministratoriProvider() : super("Administrator");

  @override
  Administrator fromJson(data) {
    return Administrator.fromJson(data);
  }
}
