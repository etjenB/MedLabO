import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/administrator/administrator.dart';
import 'package:medlabo_mobile/providers/administratori_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:provider/provider.dart';

class PomocScreen extends StatefulWidget {
  const PomocScreen({super.key});

  @override
  State<PomocScreen> createState() => _PomocScreenState();
}

class _PomocScreenState extends State<PomocScreen> {
  late AdministratoriProvider _administratoriProvider;
  List<Administrator>? administratori;

  @override
  void initState() {
    super.initState();
    _administratoriProvider = context.read<AdministratoriProvider>();
    initForm();
  }

  Future initForm() async {
    var data = await _administratoriProvider.get(filter: {'GetContacts': true});
    if (mounted) {
      setState(() {
        administratori = data.result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: administratori == null
            ? const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Text(
                        "Pomoć",
                        style: heading1,
                      ),
                      sizedBoxHeightM,
                      const Text(
                        "Ukoliko imate pitanja u vezi funkcionisanja aplikacije, usluga, testova, načina rezervisanja termina itd. možete se javiti na neki od sljedećih kontakata: ",
                        style: articleTextSmall,
                      ),
                      sizedBoxHeightM,
                      ...administratori!.map(
                        (adm) {
                          return Column(
                            children: [
                              Text(
                                adm.kontaktInfo ?? "Nepoznato",
                                style: articleTextSmall,
                              ),
                              sizedBoxHeightM,
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
