import 'package:flutter/material.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';

class ViseInformacijaPage extends StatefulWidget {
  const ViseInformacijaPage({super.key});

  @override
  State<ViseInformacijaPage> createState() => _ViseInformacijaPageState();
}

class _ViseInformacijaPageState extends State<ViseInformacijaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Paketi usluga",
                style: heading1,
              ),
              sizedBoxHeightM,
              Text(
                "Odlaskom na pakete usluga možete vidjeti koje su sve trenutno dostupne usluge. Ulaskom na pojedinačnu uslugu možete vidjeti više informacija o samoj usluzi te testove koji se nalaze u toj usluzi. Klikom na Dodaj u termin ćete dodati datu uslugu u termin kojeg možete zakazati prelaskom na stranicu Novi termin. Također, klikom na svaki pojedini test odlazite na stranicu na kojoj piše više informacija o datom testu.",
                style: articleTextSmall,
              ),
              sizedBoxHeightM,
              Text(
                "Pojedinačni testovi",
                style: heading1,
              ),
              sizedBoxHeightM,
              Text(
                "Odlaskom na pojedinačne testove moći ćete vidjeti sve trenutno dostupne testove te klikom na neki od testova odlazite na stranicu na kojoj možete pročitati nešto više o datome testu. Klikom na Dodaj u termin ćete dodati dati test u termin kojeg možete zakazati prelaskom na stranicu Novi termin.",
                style: articleTextSmall,
              ),
              sizedBoxHeightM,
              Text(
                "Meni cijena",
                style: heading1,
              ),
              sizedBoxHeightM,
              Text(
                "Odlaskom na stranicu Meni cijena možete vidjeti listu svih usluga i testova koji su trenutno dostupni te njihove cijene.",
                style: articleTextSmall,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
