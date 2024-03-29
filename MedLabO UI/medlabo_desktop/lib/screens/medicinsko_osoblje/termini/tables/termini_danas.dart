import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/rezultat/rezultat.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/models/termin/termin_test_rezultat_request.dart';
import 'package:medlabo_desktop/models/termin/termin_zakljucak_request.dart';
import 'package:medlabo_desktop/models/test/test.dart';
import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/providers/termini_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';
import 'package:medlabo_desktop/providers/usluge_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class TerminiDanasWidget extends StatefulWidget {
  const TerminiDanasWidget({super.key});

  @override
  State<TerminiDanasWidget> createState() => _TerminiDanasWidgetState();
}

class _TerminiDanasWidgetState extends State<TerminiDanasWidget>
    with PaginationMixin<Termin> {
  late TerminiProvider _terminiProvider;
  SearchResult<Termin>? termini;
  TextEditingController _terminSearchController = new TextEditingController();
  late TestoviProvider _testoviProvider;
  late UslugeProvider _uslugeProvider;

  _TerminiDanasWidgetState() {
    itemsPerPage = 4;
  }

  @override
  void initState() {
    super.initState();
    _terminiProvider = context.read<TerminiProvider>();
    _uslugeProvider = context.read<UslugeProvider>();
    _testoviProvider = context.read<TestoviProvider>();
    initForm();
    fetchPage(currentPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    var data = await _terminiProvider.get(filter: {
      'Page': 0,
      'PageSize': itemsPerPage,
      'UseSplitQuery': true,
      'Odobren': true,
      'UObradi': true,
      'TerminiToday': true,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminPacijentSpol': true,
      'IncludeTerminMedicinskoOsoblje': true,
      'IncludeTerminMedicinskoOsobljeZvanje': true,
    });

    if (mounted) {
      setState(() {
        termini = data;
        totalItems = termini!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _terminiProvider.get(filter: filter), 'FTS', {
      'UseSplitQuery': true,
      'Odobren': true,
      'UObradi': true,
      'TerminiToday': true,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminPacijentSpol': true,
      'IncludeTerminMedicinskoOsoblje': true,
      'IncludeTerminMedicinskoOsobljeZvanje': true,
    });
    if (mounted) {
      setState(() {
        termini = result;
      });
    }
  }

  void refreshWidget() {
    setState(() {
      fetchPage(currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue[900],
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _buildTerminiDanasHeader(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Container(
            height: 250,
            width: double.infinity,
            child: termini != null
                ? ListView.builder(
                    itemCount: termini!.result.length,
                    itemBuilder: (context, index) {
                      return Material(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            tileColor: Colors.blueAccent[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            mouseCursor: SystemMouseCursors.click,
                            textColor: primaryWhiteTextColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: Text(
                                      "${termini!.result[index].pacijent?.ime ?? 'Nema imena'} ${termini!.result[index].pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termini!.result[index].dtTermina!)}"),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: termini!
                                                        .result[index]
                                                        .placeno ==
                                                    true
                                                ? MaterialStatePropertyAll(
                                                    Colors.green[300])
                                                : MaterialStatePropertyAll(
                                                    Colors.orange[300]),
                                          ),
                                          onPressed: () {},
                                          child: const Icon(
                                              Icons.monetization_on_outlined),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: termini!
                                                        .result[index]
                                                        .zakljucakDodan ==
                                                    true
                                                ? MaterialStatePropertyAll(
                                                    Colors.green[300])
                                                : MaterialStatePropertyAll(
                                                    Colors.orange[300]),
                                          ),
                                          onPressed: () async {
                                            termini!.result[index]
                                                        .zakljucakDodan !=
                                                    true
                                                ? showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return _buildZakljucakDialog(
                                                          context,
                                                          termini!
                                                              .result[index]);
                                                    },
                                                  )
                                                : null;
                                          },
                                          child: const Icon(
                                              Icons.article_outlined),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: termini!
                                                        .result[index]
                                                        .rezultatDodan ==
                                                    true
                                                ? MaterialStatePropertyAll(
                                                    Colors.green[300])
                                                : MaterialStatePropertyAll(
                                                    Colors.orange[300]),
                                          ),
                                          onPressed: () async {
                                            termini!.result[index]
                                                        .rezultatDodan !=
                                                    true
                                                ? showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return FutureBuilder<
                                                          Widget>(
                                                        future:
                                                            _buildRezultatDialog(
                                                                context,
                                                                termini!.result[
                                                                    index]),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    Widget>
                                                                snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              strokeWidth: 8,
                                                            ));
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          } else {
                                                            return snapshot
                                                                .data!;
                                                          }
                                                        },
                                                      );
                                                    },
                                                  )
                                                : null;
                                          },
                                          child: const Icon(
                                              Icons.add_chart_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return FutureBuilder<Widget>(
                                    future: _buildDialogForTerminiDanasPreview(
                                        context, termini!.result[index]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Widget> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          strokeWidth: 8,
                                        ));
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return snapshot.data!;
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    widthFactor: 10,
                    heightFactor: 10,
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        const SizedBox(height: 20),
        PaginationWidget(
          key: ValueKey(currentPage),
          currentPage: currentPage,
          totalPages: totalPages,
          onPageChanged: (page) {
            fetchPage(page);
          },
        ),
      ],
    );
  }

  _buildTerminiDanasHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Termini danas',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryWhiteTextColor),
                    ),
                  ),
                  const Tooltip(
                    message:
                        'Tabela termina u kojoj se nalaze neobrađeni termini zakazani za danas.',
                    child: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: primaryWhiteTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: _buildTerminiDanasHeaderSearch(),
          ),
        ),
      ],
    );
  }

  _buildTerminiDanasHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        style: const TextStyle(color: primaryWhiteTextColor),
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: primaryLightTextColor),
          hintText: 'Pronađi pacijenta...',
          prefixIcon: Icon(
            Icons.search,
            color: primaryWhiteTextColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryWhiteTextColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryLightTextColor),
          ),
        ),
        controller: _terminSearchController,
        onSubmitted: (value) async {
          currentSearchTerm = value;
          fetchPage(1);
        },
        onChanged: (value) async {
          if (value.isEmpty) {
            currentSearchTerm = '';
            fetchPage(1);
          }
        },
      ),
    );
  }

  Future<Widget> _buildDialogForTerminiDanasPreview(
      BuildContext context, Termin termin) async {
    List<Usluga>? usluge =
        await _uslugeProvider.getUslugeByTerminId(termin.terminID!);
    List<Test>? testovi =
        await _testoviProvider.getTestoviByTerminId(termin.terminID!);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Termin: ${termin.pacijent?.ime ?? 'Nema imena'} ${termin.pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termin.dtTermina!)}",
              style: heading1,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Wrap(children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Termin odobrio/la",
                        style: heading2,
                      ),
                      Text(
                          "${termin.medicinskoOsoblje?.zvanje?.naziv}: ${termin.medicinskoOsoblje?.ime ?? 'Nepoznato'} ${termin.medicinskoOsoblje?.prezime ?? 'Nepoznato'}"),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Wrap(children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Odgovor",
                        style: heading2,
                      ),
                      Text(termin.odgovor ?? 'Nema'),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        const Text(
                          "Pacijent",
                          style: heading2,
                        ),
                        Text("Ime: ${termin.pacijent?.ime ?? 'Nepoznato'}"),
                        Text(
                            "Prezime: ${termin.pacijent?.prezime ?? 'Nepoznato'}"),
                        Text(
                            "Korisničko ime: ${termin.pacijent?.userName ?? 'Nepoznato'}"),
                        Text("Email: ${termin.pacijent?.email ?? 'Nepoznato'}"),
                        Text(
                            "Telefon: ${termin.pacijent?.phoneNumber ?? 'Nepoznato'}"),
                        Text(
                            "Spol: ${termin.pacijent?.spol?.naziv ?? 'Nepoznato'}"),
                        Text(
                            "Datum rođenja: ${termin.pacijent?.datumRodjenja == null ? 'Nepoznato' : formatDateTime(termin.pacijent!.datumRodjenja.toString())}"),
                        Text(
                            "Adresa: ${termin.pacijent?.adresa ?? 'Nepoznato'}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Napomena pacijenta",
                        style: heading2,
                      ),
                      Text(termin.napomena ?? 'Nema'),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Wrap(children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Usluge",
                        style: heading2,
                      ),
                      if (usluge.isNotEmpty)
                        ...usluge.map((element) {
                          return Text(element.naziv ?? 'Nepoznato');
                        }).toList()
                      else
                        const Text('Nema'),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Wrap(children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const Text(
                        "Testovi",
                        style: heading2,
                      ),
                      if (testovi.isNotEmpty)
                        ...testovi.map((element) {
                          return Text(element.naziv ?? 'Nepoznato');
                        }).toList()
                      else
                        const Text('Nema'),
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildZakljucakDialog(BuildContext context, Termin termin) {
    final _formKey = GlobalKey<FormBuilderState>();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                "Zaključak za termin: ${formatDateTime(termin.dtTermina!)}"),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 800,
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Opis'),
                    name: 'opis',
                    maxLength: 100,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Opis je obavezan."),
                      FormBuilderValidators.maxLength(100)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Detaljno'),
                    name: 'detaljno',
                    maxLines: 7,
                    minLines: 1,
                    maxLength: 10000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Polje 'Detaljno' je obavezno polje."),
                      FormBuilderValidators.maxLength(10000)
                    ]),
                  ),
                ],
              )),
        ),
      ),
      actions: [
        TextButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green)),
          onPressed: () async {
            if (_formKey.currentState == null ||
                !_formKey.currentState!.saveAndValidate()) {
              return;
            }

            bool shouldProceed = await showConfirmationDialog(
                context,
                'Potvrda',
                'Da li ste sigurni da želite spremiti zaključak termina?');
            if (!shouldProceed) return;

            TerminZakljucak terminZakljucak = TerminZakljucak(
              opis: _formKey.currentState?.value['opis'],
              detaljno: _formKey.currentState?.value['detaljno'],
              terminID: termin.terminID,
            );

            await _terminiProvider.terminDodavanjeZakljucka(terminZakljucak);

            makeSuccessToast("Uspješno spremljen zaključak.");

            fetchPage(currentPage);

            Navigator.of(context).pop();
          },
          child: const Text(
            'Spremi zaključak',
            style: TextStyle(color: primaryWhiteTextColor),
          ),
        ),
      ],
    );
  }

  Future<Widget> _buildRezultatDialog(
      BuildContext context, Termin termin) async {
    List<Usluga>? usluge =
        await _uslugeProvider.getUslugeByTerminId(termin.terminID!);
    List<Test>? testovi =
        await _testoviProvider.getTestoviByTerminId(termin.terminID!);
    List<Test> allTests = List.from(testovi);
    for (var usluga in usluge) {
      for (var i = 0; i < usluga.uslugaTestovi!.length; i++) {
        if (!allTests.any(
            (element) => element.testID == usluga.uslugaTestovi![i].testID)) {
          allTests.add(usluga.uslugaTestovi![i]);
        }
      }
    }
    final _formKey = GlobalKey<FormBuilderState>();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                "Rezultati za termin: ${formatDateTime(termin.dtTermina!)}"),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 800,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: allTests.map(
                (test) {
                  return Wrap(
                    children: [
                      Text(test.naziv ?? 'Nepoznato'),
                      FormBuilderTextField(
                        decoration: const InputDecoration(
                            labelText: 'Rezultat u broju'),
                        name: 'rezFlo_${test.testID}',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.numeric(
                              errorText: "Unesite ispravnu vrijednost."),
                        ]),
                      ),
                      FormBuilderTextField(
                        decoration:
                            const InputDecoration(labelText: 'Rezultat'),
                        name: 'rezStr_${test.testID}',
                        maxLength: 60,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                      ),
                      FormBuilderTextField(
                        decoration:
                            const InputDecoration(labelText: 'Zaključak testa'),
                        name: 'testZakljucak_${test.testID}',
                        maxLines: 3,
                        minLines: 1,
                        maxLength: 1000,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000),
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Zaključak je obavezan."),
                          FormBuilderValidators.maxLength(1000)
                        ]),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green)),
          onPressed: () async {
            if (_formKey.currentState == null ||
                !_formKey.currentState!.saveAndValidate()) {
              return;
            }

            bool shouldProceed = await showConfirmationDialog(context,
                'Potvrda', 'Da li ste sigurni da želite spremiti rezultate?');
            if (!shouldProceed) return;

            List<Rezultat> rezultati = [];
            for (var test in allTests) {
              var formData = _formKey.currentState!.value;

              String? rezFloString = formData['rezFlo_${test.testID}'];
              double? rezFloDouble;

              if (rezFloString != null && rezFloString.isNotEmpty) {
                rezFloDouble = parseStringToDouble(rezFloString);
                if (rezFloDouble == null) {
                  Navigator.of(context).pop();
                  makeErrorToast("Greška pri provjeri rezultata u broju.");
                  return;
                }
              }

              Rezultat rezultat = Rezultat(
                rezFlo: rezFloDouble,
                rezStr: formData['rezStr_${test.testID}'],
                testZakljucak: formData['testZakljucak_${test.testID}'],
              );
              rezultati.add(rezultat);
            }

            TerminTestRezultat terminTestRezultat = TerminTestRezultat(
              terminID: termin.terminID,
              testIDs: allTests.map((test) => test.testID!).toList(),
              rezultati: rezultati,
            );

            await _terminiProvider.terminDodavanjeRezultata(terminTestRezultat);

            makeSuccessToast("Uspješno spremljeni rezultati.");

            fetchPage(currentPage);

            Navigator.of(context).pop();
          },
          child: const Text(
            'Spremi rezultate',
            style: TextStyle(color: primaryWhiteTextColor),
          ),
        ),
      ],
    );
  }
}
