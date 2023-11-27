import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/screens/usluge_screen/pojedinacni_testovi/test_page.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class UslugaPage extends StatefulWidget {
  Usluga usluga;

  UslugaPage(this.usluga, {super.key});

  @override
  State<UslugaPage> createState() => _UslugaPageState();
}

class _UslugaPageState extends State<UslugaPage> {
  late TestoviProvider _testoviProvider;
  List<Test>? testovi;

  @override
  void initState() {
    super.initState();
    _testoviProvider = context.read<TestoviProvider>();
    initForm();
  }

  Future initForm() async {
    var data =
        await _testoviProvider.getTestoviByUslugaId(widget.usluga.uslugaID!);
    if (mounted) {
      setState(() {
        testovi = data;
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
        child: testovi == null
            ? const Center(
                widthFactor: 10,
                heightFactor: 10,
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.usluga.naziv ?? "Nema naziv",
                      style: heading1,
                    ),
                    sizedBoxHeightM,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.usluga.opis ?? "Nema opis",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Potrebno vrijeme za uzimanje uzoraka: ${widget.usluga.trajanjeUMin != null ? formatNumberToMinutes(widget.usluga.trajanjeUMin) : "Nepoznato"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Rezultat se dobija u narednih: ${widget.usluga.rezultatUH != null ? formatNumberToHours(widget.usluga.rezultatUH) : "Nepoznato"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Cijena paketa: ${widget.usluga.cijena != null ? formatNumberToPrice(widget.usluga.cijena) : "Nepoznato"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            const Text(
                              "Uključuje testove:",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            ...testovi!.map((test) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TestPage(test),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                        image: test.slika != null &&
                                                test.slika != ""
                                            ? imageFromBase64String(test.slika!)
                                                .image
                                            : const AssetImage(
                                                "assets/images/test.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          test.naziv!,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            sizedBoxHeightM,
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity,
                                    MediaQuery.of(context).size.height * 0.07),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Dodaj u termin",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
