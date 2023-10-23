import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class MedicinskoOsobljeProvider extends BaseProvider<MedicinskoOsoblje> {
  MedicinskoOsobljeProvider() : super("MedicinskoOsoblje");

  @override
  MedicinskoOsoblje fromJson(data) {
    return MedicinskoOsoblje.fromJson(data);
  }
}
