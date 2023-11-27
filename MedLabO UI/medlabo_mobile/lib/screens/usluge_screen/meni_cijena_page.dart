import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class MeniCijenaPage extends StatefulWidget {
  const MeniCijenaPage({super.key});

  @override
  State<MeniCijenaPage> createState() => _MeniCijenaPageState();
}

class _MeniCijenaPageState extends State<MeniCijenaPage> {
  late TestoviProvider _testoviProvider;
  List<Test>? testovi;
  late UslugeProvider _uslugeProvider;
  List<Usluga>? usluge;

  @override
  void initState() {
    super.initState();
    _testoviProvider = context.read<TestoviProvider>();
    _uslugeProvider = context.read<UslugeProvider>();
    initForm();
  }

  Future initForm() async {
    var dataTestovi = await _testoviProvider.getTestoviBasicData();
    var dataUsluge = await _uslugeProvider.getUslugeBasicData();
    if (mounted) {
      setState(() {
        testovi = dataTestovi;
        usluge = dataUsluge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        color: Colors.white,
        child: testovi == null || usluge == null
            ? const Center(
                widthFactor: 10,
                heightFactor: 10,
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cijene usluga",
                        style: heading1,
                      ),
                      sizedBoxHeightM,
                      ...usluge!.map((usluga) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            "${usluga.naziv}: ${usluga.cijena != null ? formatNumberToPrice(usluga.cijena) : "Nepoznato"}",
                            style: articleTextMedium,
                          ),
                        );
                      }),
                      sizedBoxHeightM,
                      const Text(
                        "Cijene testova",
                        style: heading1,
                      ),
                      sizedBoxHeightM,
                      ...testovi!.map((test) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            "${test.naziv}: ${test.cijena != null ? formatNumberToPrice(test.cijena) : "Nepoznato"}",
                            style: articleTextMedium,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
