import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/termini_provider.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/screens/usluge_screen/paketi_usluga/usluga_page.dart';
import 'package:medlabo_mobile/screens/usluge_screen/pojedinacni_testovi/test_page.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class PrethodniTerminScreen extends StatefulWidget {
  Termin termin;

  PrethodniTerminScreen(this.termin, {super.key});

  @override
  State<PrethodniTerminScreen> createState() => _PrethodniTerminScreenState();
}

class _PrethodniTerminScreenState extends State<PrethodniTerminScreen> {
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
    var dataTestovi =
        await _testoviProvider.getTestoviByTerminId(widget.termin.terminID!);
    var dataUsluge =
        await _uslugeProvider.getUslugeByTerminId(widget.termin.terminID!);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Termin - ${widget.termin.dtTermina != null ? formatDateTime(widget.termin.dtTermina!) : 'Nepoznato'}",
                        style: heading2,
                      ),
                    ),
                    sizedBoxHeightL,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Odgovor iz laboratorije: ${widget.termin.odgovor ?? "Nema"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightXL,
                            const Text(
                              "Usluge termina:",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            if (usluge!.isEmpty)
                              const Text(
                                "Nema usluga",
                                style: articleTextMedium,
                              )
                            else
                              ...usluge!.map((usluga) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UslugaPage(usluga),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                          image: usluga.slika != null &&
                                                  usluga.slika != ""
                                              ? imageFromBase64String(
                                                      usluga.slika!)
                                                  .image
                                              : const AssetImage(
                                                  "assets/images/usluge.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            usluga.naziv!,
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
                            sizedBoxHeightXL,
                            const Text(
                              "Testovi termina:",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            if (testovi!.isEmpty)
                              const Text(
                                "Nema testova",
                                style: articleTextMedium,
                              )
                            else
                              ...testovi!.map(
                                (test) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TestPage(test),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                                ? imageFromBase64String(
                                                        test.slika!)
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
                                },
                              ),
                            sizedBoxHeightXL,
                            const Text(
                              "Termin:",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pogledaj račun",
                                      style: const TextStyle(
                                        color: primaryWhiteTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeightM,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pogledaj rezultat",
                                      style: const TextStyle(
                                        color: primaryWhiteTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeightM,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Pogledaj zaključak",
                                      style: const TextStyle(
                                        color: primaryWhiteTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
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
