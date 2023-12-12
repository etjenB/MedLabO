import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:medlabo_desktop/models/pacijent/pacijent.dart';
import 'package:medlabo_desktop/models/pacijent/pacijent_update_request.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/providers/pacijenti_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/enums.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class PacijentiScreen extends StatefulWidget {
  const PacijentiScreen({super.key});

  @override
  State<PacijentiScreen> createState() => _PacijentiScreenState();
}

class _PacijentiScreenState extends State<PacijentiScreen>
    with PaginationMixin<Pacijent> {
  late PacijentProvider _pacijentiProvider;
  SearchResult<Pacijent>? pacijent;
  final TextEditingController _pacijentiSearchController =
      TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _pacijentiProvider = context.read<PacijentProvider>();
    initForm();
    fetchPage(currentPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    var data = await _pacijentiProvider.get(filter: {
      'Page': 0,
      'PageSize': itemsPerPage,
      'IncludeSpol': true,
      'IncludeSoftDeleted': false
    });
    if (mounted) {
      setState(() {
        pacijent = data;
        totalItems = pacijent!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page,
        (filter) => _pacijentiProvider.get(filter: filter),
        'ImePrezime',
        {'IncludeSpol': true, 'IncludeSoftDeleted': false});
    if (mounted) {
      setState(() {
        pacijent = result;
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
                child: _buildPacijentiHeader(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: _buildPacijentiDataTable(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPacijentiHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'Pacijenti',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryBlackTextColor))),
              RichText(
                text: const TextSpan(
                  text: 'Lista pacijenata',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: primaryDarkTextColor),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: _buildPacijentiHeaderSearch(),
          ),
        ),
      ],
    );
  }

  _buildPacijentiHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi pacijenta...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _pacijentiSearchController,
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

  _buildPacijentiDataTable(BuildContext context) {
    return Row(
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
                      label: Text(
                        'Ime',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Prezime',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'E-mail',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataColumn(
                        label: Tooltip(
                      message: 'Datum rođenja pacijenta',
                      child: Text(
                        'Datum rođenja',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Adresa stanovanja pacijenta',
                      child: Text(
                        'Adresa',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                      label: Text(
                        'Spol',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataColumn(
                        label: Tooltip(
                      message: 'Kontakt broj za pacijenta',
                      child: Text(
                        'Broj telefona',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(label: Text('Opcije')),
                  ],
                  rows: pacijent != null
                      ? pacijent!.result.map((pac) {
                          return DataRow(cells: [
                            DataCell(
                              SizedBox(
                                width: 70.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (pac.ime?.length ?? 0) > 9
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    pac.ime ?? 'Ime nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    pac.ime ?? 'Ime nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (pac.prezime?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(pac.prezime ??
                                                    'Prezime nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    pac.prezime ?? 'Prezime nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (pac.email?.length ?? 0) > 20
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    pac.email ?? 'Nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    pac.email ?? 'Nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              pac.datumRodjenja == null
                                  ? 'Nepoznat'
                                  : formatDateTime(pac.datumRodjenja.toString(),
                                          format: 'dd.MM.yyyy.') ??
                                      'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              SizedBox(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (pac.adresa?.length ?? 0) > 15
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    pac.adresa ?? 'Nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    pac.adresa ?? 'Nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(pac.spol == null && pac.spol?.naziv != null
                                ? const Text(
                                    'Nema',
                                    overflow: TextOverflow.fade,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                      child: Text(
                                        pac.spol!.naziv!,
                                        style: const TextStyle(
                                            color: primaryWhiteTextColor),
                                      ),
                                    ),
                                  )),
                            DataCell(
                              SizedBox(
                                width: 80.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (pac.phoneNumber?.length ?? 0) > 10
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(pac.phoneNumber ??
                                                    'Nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    pac.phoneNumber ?? 'Nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              _buildOptionsForPacijenti(context, pac),
                            ),
                          ]);
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsForPacijenti(BuildContext context, Pacijent pac) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_outlined),
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
      tooltip: 'Više opcija',
      onSelected: (value) async {
        switch (value) {
          case 'edit':
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _buildDialogForPacijentEdit(pac, context);
              },
            );
            break;
          case 'delete':
            await _buildLogicForPacijentDelete(context, pac);
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Tooltip(
            message: 'Izmjena podataka',
            child: Icon(Icons.mode_edit_outline_outlined),
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Tooltip(
            message: 'Obriši račun pacijenta',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogForPacijentEdit(Pacijent pac, BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Izmjena podataka pacijenta',
        style: heading1,
      ),
      scrollable: true,
      content: SizedBox(
        height: 400,
        width: 800,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(labelText: 'Ime'),
                            name: 'ime',
                            initialValue: pac.ime,
                            maxLength: 50,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Ime je obavezno."),
                              FormBuilderValidators.maxLength(50)
                            ]),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: FormBuilderTextField(
                            decoration:
                                const InputDecoration(labelText: 'Prezime'),
                            name: 'prezime',
                            initialValue: pac.prezime,
                            maxLength: 70,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(70),
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Prezime je obavezno."),
                              FormBuilderValidators.maxLength(70)
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormBuilderDateTimePicker(
                    decoration: const InputDecoration(
                      labelText: 'Datum rođenja',
                    ),
                    name: 'datumRodjenja',
                    initialDate: pac.datumRodjenja,
                    format: DateFormat('dd-MM-yyyy'),
                    inputType: InputType.date,
                    initialValue: pac.datumRodjenja,
                    firstDate: DateTime(1920),
                    lastDate: DateTime.now(),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Adresa',
                    ),
                    name: 'adresa',
                    initialValue: pac.adresa,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(70),
                    ],
                  ),
                  FormBuilderDropdown<SpolEnum>(
                    name: 'spolID',
                    decoration: const InputDecoration(labelText: 'Spol'),
                    initialValue: SpolExtension.fromInt(pac.spolID!),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: SpolEnum.values
                        .map((spol) => DropdownMenuItem(
                              value: spol,
                              child: Text(spol.displayName),
                            ))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Korisničko ime'),
                    name: 'userName',
                    initialValue: pac.userName,
                    maxLength: 30,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Korisničko ime je obavezno."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    name: 'email',
                    initialValue: pac.email,
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(60),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(
                          errorText: "Unesite ispravan email."),
                      FormBuilderValidators.required(
                          errorText: "E-mail je obavezan."),
                    ]),
                  ),
                  FormBuilderTextField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      name: 'phoneNumber',
                      initialValue: pac.phoneNumber,
                      maxLength: 10,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Telefon je obavezan."),
                      ])),
                ],
              )),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Zatvori',
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

                    bool shouldProceed = await showConfirmationDialog(
                        context,
                        'Potvrda',
                        'Da li ste sigurni da želite izmjeniti podatke profila?');
                    if (!shouldProceed) return;

                    PacijentUpdateRequest pacijentUpdateRequest =
                        PacijentUpdateRequest(
                      id: pac.id,
                      ime: _formKey.currentState?.value['ime'],
                      prezime: _formKey.currentState?.value['prezime'],
                      datumRodjenja:
                          _formKey.currentState?.value['datumRodjenja'],
                      adresa: _formKey.currentState?.value['adresa'],
                      spolID:
                          (_formKey.currentState?.value['spolID'] as SpolEnum)
                              .intValue,
                      userName: _formKey.currentState?.value['userName'],
                      email: _formKey.currentState?.value['email'],
                      phoneNumber: _formKey.currentState?.value['phoneNumber'],
                    );

                    await _pacijentiProvider.update(
                        pac.id!, pacijentUpdateRequest);

                    makeSuccessToast("Uspješno izmjenjeni podaci.");

                    fetchPage(currentPage);

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Spasi izmjene',
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

  _buildLogicForPacijentDelete(BuildContext context, Pacijent pac) async {
    if (!await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite obrisati ovog pacijenta?')) {
      return;
    }
    await _pacijentiProvider.delete(pac.id!);
    makeSuccessToast('Uspješno obrisan pacijent.');
    fetchPage(currentPage);
  }
}
