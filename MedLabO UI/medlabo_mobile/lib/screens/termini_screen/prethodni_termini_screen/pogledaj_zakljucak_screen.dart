import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/zakljucak/zakljucak.dart';
import 'package:medlabo_mobile/providers/zakljucci_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PogledajZakljucakScreen extends StatefulWidget {
  String? terminID;
  PogledajZakljucakScreen(this.terminID, {super.key});

  @override
  State<PogledajZakljucakScreen> createState() =>
      _PogledajZakljucakScreenState();
}

class _PogledajZakljucakScreenState extends State<PogledajZakljucakScreen> {
  late ZakljucciProvider _zakljucciProvider;
  Zakljucak? zakljucak;

  @override
  void initState() {
    super.initState();
    _zakljucciProvider = context.read<ZakljucciProvider>();
    initForm();
  }

  Future initForm() async {
    var data =
        await _zakljucciProvider.getZakljucakByTerminID(widget.terminID!);
    if (mounted) {
      setState(() {
        zakljucak = data;
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
        child: zakljucak == null
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
                          "Opis zakljucka",
                          style: heading1,
                        ),
                      ),
                      sizedBoxHeightL,
                      Center(
                        child: Text(
                          zakljucak!.opis ?? "Nema opisa",
                          style: heading2,
                        ),
                      ),
                      sizedBoxHeightXL,
                      const Center(
                        child: Text(
                          "Detaljno",
                          style: heading1,
                        ),
                      ),
                      sizedBoxHeightL,
                      Center(
                        child: Text(
                          zakljucak!.detaljno ?? "Nema detaljnog zakljucka",
                          style: heading2,
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
