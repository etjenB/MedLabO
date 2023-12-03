import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/racun/racun.dart';
import 'package:medlabo_mobile/providers/racuni_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PogledajRacunScreen extends StatefulWidget {
  String? terminID;
  PogledajRacunScreen(this.terminID, {super.key});

  @override
  State<PogledajRacunScreen> createState() => _PogledajRacunScreenState();
}

class _PogledajRacunScreenState extends State<PogledajRacunScreen> {
  late RacuniProvider _racuniProvider;
  Racun? racun;

  @override
  void initState() {
    super.initState();
    _racuniProvider = context.read<RacuniProvider>();
    initForm();
  }

  Future initForm() async {
    var data = await _racuniProvider.getRacunByTerminID(widget.terminID!);
    if (mounted) {
      setState(() {
        racun = data;
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
        child: racun == null
            ? const Center(
                widthFactor: 10,
                heightFactor: 10,
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Ukupna cijena",
                          style: heading1,
                        ),
                      ),
                      sizedBoxHeightL,
                      Center(
                        child: Text(
                          formatNumberToPrice(racun!.cijena),
                          style: heading2,
                        ),
                      ),
                      sizedBoxHeightXL,
                      const Center(
                        child: Text(
                          "Plaćeno",
                          style: heading1,
                        ),
                      ),
                      sizedBoxHeightL,
                      Center(
                        child: racun!.placeno == true
                            ? Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: primaryMedLabOColor,
                                      width: 2,
                                    )),
                                child: const Center(
                                  child: Text(
                                    "Da",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: primaryMedLabOColor,
                                      width: 2,
                                    )),
                                child: const Center(
                                  child: Text(
                                    "Ne",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
