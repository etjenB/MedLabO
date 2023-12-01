import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';
import 'package:medlabo_mobile/models/termin/termin_otkazivanje_request.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/termini_provider.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/screens/termini_screen/termini_screen.dart';
import 'package:medlabo_mobile/screens/usluge_screen/paketi_usluga/usluga_page.dart';
import 'package:medlabo_mobile/screens/usluge_screen/pojedinacni_testovi/test_page.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class NadolazeciTerminScreen extends StatefulWidget {
  Termin termin;

  NadolazeciTerminScreen(this.termin, {super.key});

  @override
  State<NadolazeciTerminScreen> createState() => _NadolazeciTerminScreenState();
}

class _NadolazeciTerminScreenState extends State<NadolazeciTerminScreen> {
  late TestoviProvider _testoviProvider;
  List<Test>? testovi;
  late UslugeProvider _uslugeProvider;
  List<Usluga>? usluge;
  late TerminiProvider _terminiProvider;

  @override
  void initState() {
    super.initState();
    _testoviProvider = context.read<TestoviProvider>();
    _uslugeProvider = context.read<UslugeProvider>();
    _terminiProvider = context.read<TerminiProvider>();
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
                                  padding: const EdgeInsets.only(bottom: 8),
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
                                    padding: const EdgeInsets.only(bottom: 8),
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
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
                                  "Cijena - ${formatNumberToPrice(calculateTotalPrice())}",
                                  style: const TextStyle(
                                    color: primaryWhiteTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeightXL,
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool shouldProceed = await showConfirmationDialog(
                                      context,
                                      'Potvrda',
                                      'Da li ste sigurni da želite otkazati termin?');
                                  if (!shouldProceed) return;

                                  TerminOtkazivanjeRequest
                                      terminOtkazivanjeRequest =
                                      TerminOtkazivanjeRequest(
                                    terminID: widget.termin.terminID,
                                  );

                                  await _terminiProvider.terminOtkazivanje(
                                      terminOtkazivanjeRequest);

                                  makeAlertToast("Termin otkazan.", "warning",
                                      Alignment.center);

                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.red),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Otkaži termin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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

  double calculateTotalPrice() {
    double total = 0.0;

    if (usluge != null) {
      for (var usluga in usluge!) {
        total += usluga.cijena ?? 0.0;
      }
    }

    if (testovi != null) {
      for (var test in testovi!) {
        total += test.cijena ?? 0.0;
      }
    }

    return total;
  }
}
