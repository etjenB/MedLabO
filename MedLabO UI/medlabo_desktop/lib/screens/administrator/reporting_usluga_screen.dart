import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/providers/termini_provider.dart';
import 'package:medlabo_desktop/providers/usluge_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:provider/provider.dart';

class ReportingUslugaScreen extends StatefulWidget {
  const ReportingUslugaScreen({super.key});

  @override
  State<ReportingUslugaScreen> createState() => _ReportingUslugaScreenState();
}

class _ReportingUslugaScreenState extends State<ReportingUslugaScreen>
    with PaginationMixin<Termin> {
  late TerminiProvider _terminiProvider;
  SearchResult<Termin>? termini;
  late UslugeProvider _uslugeProvider;
  SearchResult<Usluga>? usluge;
  var currentUslugaId = 1;
  double ukupanIznos = 0;
  final _detailsFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _terminiProvider = context.read<TerminiProvider>();
    _uslugeProvider = context.read<UslugeProvider>();
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
      'TerminWhereUslugaId': currentUslugaId,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminUsluge': true,
      'IncludeTerminRacun': true
    });
    var _usluge = await _uslugeProvider.get();
    if (mounted) {
      setState(() {
        termini = data;
        totalItems = termini!.count;
        usluge = _usluge;
        ukupanIznos = 0;
        for (var element in termini!.result) {
          ukupanIznos += element.racun!.cijena!;
        }
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _terminiProvider.get(filter: filter), 'FTS', {
      'UseSplitQuery': true,
      'TerminWhereUslugaId': currentUslugaId,
      'OrderByDTTermina': true,
      'IncludeTerminPacijent': true,
      'IncludeTerminUsluge': true,
      'IncludeTerminRacun': true
    });
    if (mounted) {
      setState(() {
        termini = result;
        ukupanIznos = 0;
        for (var element in termini!.result) {
          ukupanIznos += element.racun!.cijena!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _buildReportingUslugaHeader(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: usluge != null
                    ? _buildReportingUslugaContent()
                    : const SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildReportingUslugaHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'Reporting usluga',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryBlackTextColor))),
              RichText(
                text: const TextSpan(
                  text: 'Poslovni reporting usluga za laboratorij',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: primaryDarkTextColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildReportingUslugaContent() {
    return Column(
      children: [
        _buildUslugeSearch(),
        /*usluge != null
            ? _buildUslugeSearch()
            : const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(),
              ),*/
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => tableHeaderColor),
                      columns: const [
                        DataColumn(
                            label: Tooltip(
                          message: 'Datum termina',
                          child: Text(
                            'Datum',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        DataColumn(
                            label: Tooltip(
                          message: 'Ime pacijenta',
                          child: Text(
                            'Pacijent',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        DataColumn(
                            label: Tooltip(
                          message: 'Odabrana usluga',
                          child: Text(
                            'Usluga',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        DataColumn(
                          label: Tooltip(
                            message: 'Ukupan iznos plaćen za termin',
                            child: Text(
                              'Iznos',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      rows: termini != null
                          ? termini!.result.map((termin) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    termin.dtTermina == null
                                        ? 'Nema'
                                        : formatDateTime(termin.dtTermina!) ??
                                            'Nema',
                                    overflow: TextOverflow.fade,
                                  )),
                                  DataCell(
                                    SizedBox(
                                      width: 100.0,
                                      child: Text(
                                        termin.pacijent!.ime! +
                                            ' ' +
                                            termin.pacijent!.prezime!,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 100.0,
                                      child: Text(
                                        usluge!.result
                                            .where((element) =>
                                                element.uslugaID ==
                                                currentUslugaId)
                                            .first
                                            .naziv!,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatNumberToPrice(termin.racun!.cijena),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                          : [],
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
                  sizedBoxHeightL,
                  Container(
                    child: Text('Ukupan iznos' + ukupanIznos.toString()),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildUslugeSearch() {
    return Container(
      width: 300,
      height: 300,
      child: FormBuilder(
        key: _detailsFormKey,
        child: Column(
          children: [
            Text("Od"),
            sizedBoxHeightM,
            FormBuilderDateTimePicker(name: 'Od'),
            sizedBoxHeightM,
            Text("Do"),
            sizedBoxHeightM,
            FormBuilderDateTimePicker(name: 'Do'),
            sizedBoxHeightM,
            FormBuilderDropdown<int>(
              name: 'uslugaID',
              decoration: const InputDecoration(labelText: 'Usluga'),
              initialValue: usluge!.result.first.uslugaID,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
              items: usluge!.result
                  .map((usluga) => DropdownMenuItem(
                        value: usluga.uslugaID,
                        child: Text(usluga.naziv!),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                onPressed: () async {
                  if (_detailsFormKey.currentState == null ||
                      !_detailsFormKey.currentState!.saveAndValidate()) {
                    return;
                  }

                  var _termini = await _terminiProvider.get(filter: {
                    'UseSplitQuery': true,
                    /*'TerminiFrom': '25/01/2024',
                    'TerminiTo': '27/01/2024',*/
                    'TerminiFrom': _detailsFormKey.currentState?.value['Od'],
                    'TerminiTo': _detailsFormKey.currentState?.value['Do'],
                    'TerminWhereUslugaId':
                        _detailsFormKey.currentState?.value['uslugaID'] as int,
                    'OrderByDTTermina': true,
                    'IncludeTerminPacijent': true,
                    'IncludeTerminUsluge': true,
                    'IncludeTerminRacun': true
                  });

                  setState(() {
                    currentUslugaId =
                        _detailsFormKey.currentState?.value['uslugaID'] as int;
                    termini = null;
                    termini = _termini;
                    ukupanIznos = 0;
                    for (var element in termini!.result) {
                      ukupanIznos += element.racun!.cijena!;
                    }
                  });
                },
                child: const Text(
                  'Pretraži',
                  style: TextStyle(color: primaryWhiteTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
