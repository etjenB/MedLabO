import 'package:flutter/material.dart';
import 'package:medlabo_desktop/screens/medicinsko_osoblje/termini/tables/nadolazeci_termini.dart';
import 'package:medlabo_desktop/screens/medicinsko_osoblje/termini/tables/nedovrseni_termini.dart';
import 'package:medlabo_desktop/screens/medicinsko_osoblje/termini/tables/tabela_za_odobrenja.dart';
import 'package:medlabo_desktop/screens/medicinsko_osoblje/termini/tables/termini_danas.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({super.key});

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  final GlobalKey<NadolazeciTerminiWidgetState> nadolazeciTerminiKey =
      GlobalKey();

  void refreshNadolazeciTermini() {
    nadolazeciTerminiKey.currentState?.refreshWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TerminiDanasWidget(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TabelaZaOdobrenjaWidget(
                          onRefreshNadolazeciTermini: refreshNadolazeciTermini),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: NedovrseniTerminiWidget(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: NadolazeciTerminiWidget(key: nadolazeciTerminiKey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
