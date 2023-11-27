import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/common/change_password_request.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje_registration_request.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje_update_request.dart';
import 'package:medlabo_desktop/providers/medicinsko_osoblje_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/enums.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class UposleniciScreen extends StatefulWidget {
  const UposleniciScreen({super.key});

  @override
  State<UposleniciScreen> createState() => _UposleniciScreenState();
}

class _UposleniciScreenState extends State<UposleniciScreen>
    with PaginationMixin<MedicinskoOsoblje> {
  late MedicinskoOsobljeProvider _medicinskoOsobljeProvider;
  SearchResult<MedicinskoOsoblje>? medicinskoOsoblje;
  TextEditingController _medicinskoOsobljeSearchController =
      new TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _medicinskoOsobljeProvider = context.read<MedicinskoOsobljeProvider>();
    initForm();
    fetchPage(currentPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    var data = await _medicinskoOsobljeProvider.get(filter: {
      'Page': 0,
      'PageSize': itemsPerPage,
      'IncludeSpol': true,
      'IncludeZvanje': true,
      'IncludeSoftDeleted': false
    });
    if (mounted) {
      setState(() {
        medicinskoOsoblje = data;
        totalItems = medicinskoOsoblje!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page,
        (filter) => _medicinskoOsobljeProvider.get(filter: filter),
        'ImePrezime', {
      'IncludeSpol': true,
      'IncludeZvanje': true,
      'IncludeSoftDeleted': false
    });
    if (mounted) {
      setState(() {
        medicinskoOsoblje = result;
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
                child: _buildUposleniciHeader(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: _buildUposleniciDataTable(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUposleniciHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'Uposlenici',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryBlackTextColor))),
              RichText(
                text: const TextSpan(
                  text: 'Lista uposlenika',
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
            child: _buildUposleniciHeaderSearch(),
          ),
        ),
        Flexible(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return _buildDialogForUposlenikAdd(context);
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                    flex: 1,
                    child: Icon(Icons.add, color: primaryLightTextColor)),
                const Flexible(child: SizedBox(width: 8)),
                Flexible(
                  flex: 9,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Registruj uposlenika',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: primaryWhiteTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildUposleniciHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi uposlenika...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _medicinskoOsobljeSearchController,
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

  _buildDialogForUposlenikAdd(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Registracija novog uposlenika',
        style: heading1,
      ),
      scrollable: true,
      content: Container(
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
                  FormBuilderCheckbox(
                    name: 'isActive',
                    initialValue: true,
                    title: const Text('Aktivan'),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderDropdown<SpolEnum>(
                    name: 'spolID',
                    decoration: const InputDecoration(labelText: 'Spol'),
                    initialValue: SpolEnum.musko,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: SpolEnum.values
                        .map((spol) => DropdownMenuItem(
                              value: spol,
                              child: Text(spol.displayName),
                            ))
                        .toList(),
                  ),
                  FormBuilderDropdown<ZvanjeEnum>(
                    name: 'zvanjeID',
                    decoration: const InputDecoration(labelText: 'Zvanje'),
                    initialValue: ZvanjeEnum.ljekar,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: ZvanjeEnum.values
                        .map((zvanje) => DropdownMenuItem(
                              value: zvanje,
                              child: Text(zvanje.displayName),
                            ))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Korisničko ime'),
                    name: 'userName',
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
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(60),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(
                          errorText: "Unesite pravilan email."),
                      FormBuilderValidators.required(
                          errorText: "E-mail je obavezan."),
                    ]),
                  ),
                  FormBuilderTextField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      name: 'phoneNumber',
                      maxLength: 10,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Telefon je obavezan."),
                      ])),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Lozinka'),
                    name: 'password',
                    maxLength: 30,
                    obscureText: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Lozinka je obavezna."),
                      FormBuilderValidators.minLength(8,
                          errorText:
                              "Lozinka mora imati minimalno 8 karaktera."),
                      FormBuilderValidators.maxLength(30,
                          errorText:
                              "Lozinka može imati maksimalno 30 karaktera."),
                      (val) {
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedno veliko slovo';
                        }
                        return null;
                      },
                      (val) {
                        if (!RegExp(r'(?=.*[a-z])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedno malo slovo';
                        }
                        return null;
                      },
                      (val) {
                        if (!RegExp(r'(?=.*[0-9])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedan broj';
                        }
                        return null;
                      },
                    ]),
                  ),
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
                        'Da li ste sigurni da želite kreirati novi račun za uposlenika?');
                    if (!shouldProceed) return;

                    MedicinskoOsobljeRegistrationRequest
                        medicinskoOsobljeRegistrationRequest =
                        MedicinskoOsobljeRegistrationRequest(
                      ime: _formKey.currentState?.value['ime'],
                      prezime: _formKey.currentState?.value['prezime'],
                      isActive:
                          _formKey.currentState?.value['isActive'] as bool? ??
                              false,
                      spolID:
                          (_formKey.currentState?.value['spolID'] as SpolEnum)
                              .intValue,
                      zvanjeID: (_formKey.currentState?.value['zvanjeID']
                              as ZvanjeEnum)
                          .intValue,
                      userName: _formKey.currentState?.value['userName'],
                      password: _formKey.currentState?.value['password'],
                      email: _formKey.currentState?.value['email'],
                      phoneNumber: _formKey.currentState?.value['phoneNumber'],
                    );

                    await _medicinskoOsobljeProvider
                        .insert(medicinskoOsobljeRegistrationRequest);

                    makeSuccessToast("Uspješno dodan račun.");

                    fetchPage(currentPage);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Kreiraj račun',
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

  _buildUposleniciDataTable(BuildContext context) {
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
                      message: 'Datum kreiranja računa uposlenika',
                      child: Text(
                        'Datum zaposlenja',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Datum deaktiviranja računa uposlenika',
                      child: Text(
                        'Prekid rada',
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
                      message: 'Račun uposlenika aktivan?',
                      child: Text(
                        'Aktivan',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(label: Text('Opcije')),
                  ],
                  rows: medicinskoOsoblje != null
                      ? medicinskoOsoblje!.result.map((medOso) {
                          return DataRow(cells: [
                            DataCell(
                              SizedBox(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (medOso.ime?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(medOso.ime ??
                                                    'Ime nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    medOso.ime ?? 'Ime nepoznato',
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
                                    (medOso.prezime?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(medOso.prezime ??
                                                    'Prezime nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    medOso.prezime ?? 'Prezime nepoznato',
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
                                    (medOso.email?.length ?? 0) > 20
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(medOso.email ??
                                                    'Nepoznato'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    medOso.email ?? 'Nepoznato',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              medOso.dtZaposlenja == null
                                  ? 'Nepoznat'
                                  : formatDateTime(medOso.dtZaposlenja!) ??
                                      'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              medOso.dtPrekidRadnogOdnosa == null
                                  ? 'Nema'
                                  : formatDateTime(
                                          medOso.dtPrekidRadnogOdnosa!) ??
                                      'Nema',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(medOso.spol == null &&
                                    medOso.spol?.naziv != null
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
                                        medOso.spol!.naziv!,
                                        style: const TextStyle(
                                            color: primaryWhiteTextColor),
                                      ),
                                    ),
                                  )),
                            DataCell(medOso.isActive == null
                                ? const Text(
                                    'Nepoznato',
                                    overflow: TextOverflow.fade,
                                  )
                                : medOso.isActive == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.green[300],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 2)),
                                          child: const Text(
                                            'Da',
                                            style: TextStyle(
                                                color: primaryWhiteTextColor),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.red[300],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.red, width: 2)),
                                          child: const Text(
                                            'Ne',
                                            style: TextStyle(
                                                color: primaryWhiteTextColor),
                                          ),
                                        ),
                                      )),
                            DataCell(
                              _buildOptionsForMedicinskoOsoblje(
                                  context, medOso),
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

  Widget _buildOptionsForMedicinskoOsoblje(
      BuildContext context, MedicinskoOsoblje medOso) {
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
                return _buildDialogForUposlenikEdit(medOso, context);
              },
            );
            break;
          case 'changePassword':
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _buildDialogForUposlenikChangePassword(medOso, context);
              },
            );
          case 'delete':
            await _buildLogicForUposlenikDelete(context, medOso);
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
          value: 'changePassword',
          child: Tooltip(
            message: 'Promjena lozinke',
            child: Icon(Icons.password_outlined),
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Tooltip(
            message: 'Obriši račun uposlenika',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogForUposlenikEdit(
      MedicinskoOsoblje medOso, BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Izmjena podataka uposlenika',
        style: heading1,
      ),
      scrollable: true,
      content: Container(
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
                            initialValue: medOso.ime,
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
                            initialValue: medOso.prezime,
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
                  FormBuilderCheckbox(
                    name: 'isActive',
                    initialValue: medOso.isActive,
                    title: const Text('Aktivan'),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderDropdown<SpolEnum>(
                    name: 'spolID',
                    decoration: const InputDecoration(labelText: 'Spol'),
                    initialValue: SpolExtension.fromInt(medOso.spol!.spolID!),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: SpolEnum.values
                        .map((spol) => DropdownMenuItem(
                              value: spol,
                              child: Text(spol.displayName),
                            ))
                        .toList(),
                  ),
                  FormBuilderDropdown<ZvanjeEnum>(
                    name: 'zvanjeID',
                    decoration: const InputDecoration(labelText: 'Zvanje'),
                    initialValue:
                        ZvanjeExtension.fromInt(medOso.zvanje!.zvanjeID!),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: ZvanjeEnum.values
                        .map((zvanje) => DropdownMenuItem(
                              value: zvanje,
                              child: Text(zvanje.displayName),
                            ))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Korisničko ime'),
                    name: 'userName',
                    initialValue: medOso.userName,
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
                    initialValue: medOso.email,
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
                      initialValue: medOso.phoneNumber,
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
                        'Da li ste sigurni da želite izmjeniti podatke uposlenika?');
                    if (!shouldProceed) return;

                    MedicinskoOsobljeUpdateRequest
                        medicinskoOsobljeUpdateRequest =
                        MedicinskoOsobljeUpdateRequest(
                      id: medOso.id,
                      ime: _formKey.currentState?.value['ime'],
                      prezime: _formKey.currentState?.value['prezime'],
                      isActive:
                          _formKey.currentState?.value['isActive'] as bool? ??
                              false,
                      spolID:
                          (_formKey.currentState?.value['spolID'] as SpolEnum)
                              .intValue,
                      zvanjeID: (_formKey.currentState?.value['zvanjeID']
                              as ZvanjeEnum)
                          .intValue,
                      userName: _formKey.currentState?.value['userName'],
                      email: _formKey.currentState?.value['email'],
                      phoneNumber: _formKey.currentState?.value['phoneNumber'],
                    );

                    await _medicinskoOsobljeProvider.update(
                        medOso.id!, medicinskoOsobljeUpdateRequest);

                    makeSuccessToast("Uspješno izmjenjeni podaci.");

                    fetchPage(currentPage);

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

  _buildLogicForUposlenikDelete(
      BuildContext context, MedicinskoOsoblje medOso) async {
    if (!await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite obrisati ovog uposlenika?')) {
      return;
    }
    await _medicinskoOsobljeProvider.delete(medOso.id!);
    makeSuccessToast('Uspješno obrisan uposlenik.');
    fetchPage(currentPage);
  }

  Widget _buildDialogForUposlenikChangePassword(
      MedicinskoOsoblje medOso, BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Promjena lozinke uposlenika',
        style: heading1,
      ),
      scrollable: true,
      content: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FormBuilder(
              key: _formKey,
              child: Column(children: [
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Stara lozinka'),
                  name: 'oldPassword',
                  maxLength: 30,
                  obscureText: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Lozinka je obavezna."),
                    FormBuilderValidators.maxLength(30,
                        errorText:
                            "Lozinka može imati maksimalno 30 karaktera."),
                  ]),
                ),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Nova Lozinka'),
                  name: 'newPassword',
                  maxLength: 30,
                  obscureText: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Lozinka je obavezna."),
                    FormBuilderValidators.minLength(8,
                        errorText: "Lozinka mora imati minimalno 8 karaktera."),
                    FormBuilderValidators.maxLength(30,
                        errorText:
                            "Lozinka može imati maksimalno 30 karaktera."),
                    (val) {
                      if (!RegExp(r'(?=.*[A-Z])').hasMatch(val ?? '')) {
                        return 'Mora sadržavati najmanje jedno veliko slovo';
                      }
                      return null;
                    },
                    (val) {
                      if (!RegExp(r'(?=.*[a-z])').hasMatch(val ?? '')) {
                        return 'Mora sadržavati najmanje jedno malo slovo';
                      }
                      return null;
                    },
                    (val) {
                      if (!RegExp(r'(?=.*[0-9])').hasMatch(val ?? '')) {
                        return 'Mora sadržavati najmanje jedan broj';
                      }
                      return null;
                    },
                  ]),
                ),
              ])),
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
                        'Da li ste sigurni da želite promjeniti lozinku uposlenika?');
                    if (!shouldProceed) return;

                    ChangePasswordRequest changePasswordRequest =
                        ChangePasswordRequest(
                            userId: medOso.id,
                            oldPassword:
                                _formKey.currentState?.value['oldPassword'],
                            newPassword:
                                _formKey.currentState?.value['newPassword']);

                    await _medicinskoOsobljeProvider
                        .changePassword(changePasswordRequest);

                    makeSuccessToast("Uspješno promjenjena lozinka.");

                    fetchPage(currentPage);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Spasi promjenu',
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
}
