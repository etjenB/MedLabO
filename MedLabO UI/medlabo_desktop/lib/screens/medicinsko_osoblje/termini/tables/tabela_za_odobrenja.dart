import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/models/termin/termin_odobravanje_request.dart';
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

class TabelaZaOdobrenjaWidget extends StatefulWidget {
  final Function onRefreshNadolazeciTermini;

  const TabelaZaOdobrenjaWidget(
      {Key? key, required this.onRefreshNadolazeciTermini})
      : super(key: key);

  @override
  State<TabelaZaOdobrenjaWidget> createState() =>
      _TabelaZaOdobrenjaWidgetState();
}

class _TabelaZaOdobrenjaWidgetState extends State<TabelaZaOdobrenjaWidget>
    with PaginationMixin<Termin> {
  late TerminiProvider _terminiProvider;
  SearchResult<Termin>? termini;
  TextEditingController _terminSearchController = new TextEditingController();
  late TestoviProvider _testoviProvider;
  late UslugeProvider _uslugeProvider;

  _TabelaZaOdobrenjaWidgetState() {
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
      'NaCekanju': true,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminPacijentSpol': true,
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
      'NaCekanju': true,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminPacijentSpol': true,
    });
    if (mounted) {
      setState(() {
        termini = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue[900],
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _buildTabelaZaOdobrenjaHeader(),
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
                                  flex: 7,
                                  child: Text(
                                      "${termini!.result[index].pacijent?.ime ?? 'Nema imena'} ${termini!.result[index].pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termini!.result[index].dtTermina!)}"),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.red[400])),
                                              onPressed: () async {
                                                await _odbijTermin(
                                                    termini!.result[index],
                                                    null);
                                              },
                                              child: const Text("Odbij"))),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.green[400])),
                                          onPressed: () async {
                                            await _odobriTermin(
                                                termini!.result[index], null);
                                          },
                                          child: const Text("Odobri"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return FutureBuilder<Widget>(
                                    future: _buildDialogForTerminZahtjevPreview(
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

  _buildTabelaZaOdobrenjaHeader() {
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
                      text: 'Tabela za odobrenja',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryWhiteTextColor),
                    ),
                  ),
                  const Tooltip(
                    message:
                        'Tabela termina u kojoj se nalaze termini koji tek trebaju biti odobreni ili odbijeni.',
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
            child: _buildTabelaZaOdobrenjaHeaderSearch(),
          ),
        ),
      ],
    );
  }

  _buildTabelaZaOdobrenjaHeaderSearch() {
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

  Future<Widget> _buildDialogForTerminZahtjevPreview(
      BuildContext context, Termin termin) async {
    List<Usluga>? usluge =
        await _uslugeProvider.getUslugeByTerminId(termin.terminID!);
    List<Test>? testovi =
        await _testoviProvider.getTestoviByTerminId(termin.terminID!);
    final _formKey = GlobalKey<FormBuilderState>();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Zahtjev za termin: ${termin.pacijent?.ime ?? 'Nema imena'} ${termin.pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termin.dtTermina!)}",
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
            const SizedBox(
              height: 5,
            ),
            FormBuilder(
              key: _formKey,
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: 'Odgovor'),
                name: 'odgovor',
                maxLength: 300,
                minLines: 1,
                maxLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(300),
                ],
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.maxLength(300)]),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () async {
                    if (_formKey.currentState == null ||
                        !_formKey.currentState!.saveAndValidate()) {
                      return;
                    }

                    await _odbijTermin(
                        termin, _formKey.currentState?.value['odgovor']);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Odbij zahtjev',
                    style: TextStyle(color: primaryWhiteTextColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    if (_formKey.currentState == null ||
                        !_formKey.currentState!.saveAndValidate()) {
                      return;
                    }

                    await _odobriTermin(
                        termin, _formKey.currentState?.value['odgovor']);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Odobri termin',
                    style: TextStyle(color: primaryWhiteTextColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future _odbijTermin(Termin termin, dynamic odgovorValue) async {
    bool shouldProceed = await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite odbiti zahtjev za termin?');
    if (!shouldProceed) return;

    TerminOdobravanjeRequest terminOdobravanjeRequest =
        TerminOdobravanjeRequest(
      terminID: termin.terminID,
      odgovor: odgovorValue,
      status: false,
    );

    await _terminiProvider.terminOdobravanje(terminOdobravanjeRequest);

    makeAlertToast("Zahtjev za termin odbijen.", "warning", Alignment.center);

    fetchPage(currentPage);
  }

  Future _odobriTermin(Termin termin, dynamic odgovorValue) async {
    bool shouldProceed = await showConfirmationDialog(
        context, 'Potvrda', 'Da li ste sigurni da želite odobriti termin?');
    if (!shouldProceed) return;

    TerminOdobravanjeRequest terminOdobravanjeRequest =
        TerminOdobravanjeRequest(
      terminID: termin.terminID,
      odgovor: odgovorValue,
      status: true,
    );

    await _terminiProvider.terminOdobravanje(terminOdobravanjeRequest);

    makeSuccessToast("Uspješno odobren termin.");

    widget.onRefreshNadolazeciTermini();

    fetchPage(currentPage);
  }
}
