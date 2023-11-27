import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/models/test_parametar/test_parametar.dart';
import 'package:medlabo_mobile/providers/test_parametri_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  Test test;

  TestPage(this.test, {super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late TestParametriProvider _testParametriProvider;
  TestParametar? testParametar;

  @override
  void initState() {
    super.initState();
    _testParametriProvider = context.read<TestParametriProvider>();
    initForm();
  }

  Future initForm() async {
    var data =
        await _testParametriProvider.getById(widget.test.testParametarID!);
    if (mounted) {
      setState(() {
        testParametar = data;
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
        child: testParametar == null
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
                      widget.test.naziv ?? "Nema naziv",
                      style: heading1,
                    ),
                    sizedBoxHeightM,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.test.opis ?? "Nema opis",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Napomena za pripremu pred test: ${widget.test.napomenaZaPripremu ?? "Nema"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Tip uzorka potreban za test: ${widget.test.tipUzorka ?? "Nepoznato"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            Text(
                              "Cijena testa: ${widget.test.cijena != null ? formatNumberToPrice(widget.test.cijena) : "Nepoznato"}",
                              style: articleTextMedium,
                            ),
                            sizedBoxHeightM,
                            if (testParametar?.minVrijednost != null)
                              Text(
                                "Minimalna normala vrijednost: ${testParametar!.minVrijednost} ${testParametar!.jedinica}",
                                style: articleTextMedium,
                              ),
                            sizedBoxHeightM,
                            if (testParametar?.maxVrijednost != null)
                              Text(
                                "Maksimalna normala vrijednost: ${testParametar!.maxVrijednost} ${testParametar!.jedinica}",
                                style: articleTextMedium,
                              ),
                            sizedBoxHeightM,
                            if (testParametar?.normalnaVrijednost != null)
                              Text(
                                "Maksimalna normala vrijednost: ${testParametar!.normalnaVrijednost}",
                                style: articleTextMedium,
                              ),
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
