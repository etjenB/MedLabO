import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/screens/usluge_screen/paketi_usluga/usluga_page.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class PreporuceneUslugeScreen extends StatefulWidget {
  const PreporuceneUslugeScreen({super.key});

  @override
  State<PreporuceneUslugeScreen> createState() =>
      _PreporuceneUslugeScreenState();
}

class _PreporuceneUslugeScreenState extends State<PreporuceneUslugeScreen> {
  late UslugeProvider _uslugeProvider;
  List<Usluga>? usluge;

  @override
  void initState() {
    _uslugeProvider = context.read<UslugeProvider>();
    super.initState();
    initForm();
  }

  Future initForm() async {
    var uslugaId = await _uslugeProvider.getPacijentLastChosenUsluga();
    if (uslugaId == null) {
      setState(() {
        usluge = [];
      });
      return;
    }
    var data = await _uslugeProvider.recommend(uslugaId);
    setState(() {
      usluge = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(children: [
            const Center(
              child: Text(
                "Usluge",
                style: TextStyle(
                    color: primaryMedLabOColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (usluge == null)
                      const Center(child: CircularProgressIndicator())
                    else if (usluge!.isEmpty)
                      const Text('Nema preporučenih usluga')
                    else
                      ...usluge!.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UslugaPage(item),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.15,
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: item.slika != null && item.slika != ""
                                      ? imageFromBase64String(item.slika!).image
                                      : const AssetImage(
                                          "assets/images/paketiUsluga.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    item.naziv!,
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
                      }).toList(),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
