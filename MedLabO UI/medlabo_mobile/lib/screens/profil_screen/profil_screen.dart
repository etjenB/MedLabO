import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent.dart';
import 'package:medlabo_mobile/providers/pacijenti_provider.dart';
import 'package:medlabo_mobile/screens/profil_screen/sigurnost_screen.dart';
import 'package:medlabo_mobile/screens/profil_screen/uredjivanje_profila_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Pacijent? user;
  late PacijentProvider _pacijentiProvider;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _pacijentiProvider = context.read<PacijentProvider>();
    initForm();
  }

  Future initForm() async {
    var authUtil = await AuthUtil.create();
    var data = await _pacijentiProvider.getById(authUtil.getUserId());
    if (mounted) {
      setState(() {
        user = data;
      });
    }
  }

  void updateUser(Pacijent updatedUser) {
    setState(() {
      user = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: user == null
          ? const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: const BoxDecoration(color: primaryMedLabOColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          "${user!.ime} ${user!.prezime}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                        Center(
                            child: Text(
                          "${user!.email}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UredjivanjeProfilaScreen(user,
                          updateUser: updateUser))),
                  leading: const Icon(Icons.person_2_outlined),
                  title: const Text("Uređivanje profila"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  tileColor: Colors.grey[200],
                ),
                sizedBoxHeightS,
                ListTile(
                  onTap: () => SigurnostScreen(user),
                  leading: const Icon(Icons.lock_person_outlined),
                  title: const Text("Sigurnost"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  tileColor: Colors.grey[200],
                ),
                sizedBoxHeightS,
                ListTile(
                  leading: const Icon(Icons.contact_mail_outlined),
                  title: const Text("Kontaktirajte nas"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  tileColor: Colors.grey[200],
                ),
                sizedBoxHeightS,
                ListTile(
                  leading: const Icon(Icons.question_mark_outlined),
                  title: const Text("Pomoć"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  tileColor: Colors.grey[200],
                ),
                sizedBoxHeightL,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await showConfirmationDialog(context, "Odjava",
                          "Jeste li sigurni da se želite odjaviti?")) {
                        storage.delete(key: 'jwt_token');
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(primaryMedLabOColor),
                    ),
                    child: const Center(
                      child: Text(
                        "Odjavi se",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
