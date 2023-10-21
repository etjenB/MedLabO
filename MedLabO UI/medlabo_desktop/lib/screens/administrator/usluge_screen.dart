import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/test/test.dart';
import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/models/usluga/usluga_request.dart';
import 'package:medlabo_desktop/providers/usluge_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/nums.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class UslugeScreen extends StatefulWidget {
  const UslugeScreen({super.key});

  @override
  State<UslugeScreen> createState() => _UslugeScreenState();
}

class _UslugeScreenState extends State<UslugeScreen>
    with PaginationMixin<Usluga> {
  late UslugeProvider _uslugeProvider;
  SearchResult<Usluga>? usluge;
  final TextEditingController _uslugaSearchController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _uslugeProvider = context.read<UslugeProvider>();
    initForm();
    fetchPage(currentPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    var data = await _uslugeProvider
        .get(filter: {'Page': 0, 'PageSize': itemsPerPage});
    if (mounted) {
      setState(() {
        usluge = data;
        totalItems = usluge!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _uslugeProvider.get(filter: filter), 'Naziv');
    setState(() {
      usluge = result;
    });
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
                child: _buildUslugeHeader(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: _buildUslugeDataTable(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUslugeHeader() {
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
                      text: 'Usluge',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryBlackTextColor))),
              RichText(
                  text: const TextSpan(
                      text: 'Paketi usluga',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: primaryDarkTextColor))),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: _buildUslugeHeaderSearch(),
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
                      return _buildDialogForUslugaAdd(context);
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 3,
                        child: Icon(Icons.add, color: primaryLightTextColor)),
                    const Flexible(child: SizedBox(width: 8)),
                    Flexible(
                      flex: 7,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Dodaj uslugu',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: primaryWhiteTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }

  SizedBox _buildUslugeHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi uslugu...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _uslugaSearchController,
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

  _buildDialogForUslugaAdd(BuildContext context) {}

  _buildUslugeDataTable(BuildContext context) {
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
                        label: Tooltip(
                      message: 'Ime usluge',
                      child: Text(
                        'Naziv',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Kratak opis usluge',
                      child: Text(
                        'Opis',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Cijena usluge',
                      child: Text(
                        'Cijena',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message:
                          'Prosječno potrebno vrijeme za uzimanje uzoraka potrebnih za uslugu',
                      child: Text(
                        'Trajanje',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Prosječno vrijeme za obradu testova usluge',
                      child: Text(
                        'Rezultat',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Da li je usluga dostupna pacijentima',
                      child: Text(
                        'Dostupno',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Datum kada je kreirana usluga',
                      child: Text(
                        'Datum kreiranja',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message:
                          'Datum kada su zadnji put izmjenjeni podaci o usluzi',
                      child: Text(
                        'Zadnja izmjena',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(label: Text('Opcije')),
                  ],
                  rows: usluge != null
                      ? usluge!.result.map((usluga) {
                          return DataRow(cells: [
                            DataCell(
                              SizedBox(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (usluga.naziv?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(usluga.naziv ??
                                                    'Nema naziv'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    usluga.naziv ?? 'Nema naziv',
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
                                    (usluga.opis?.length ?? 0) > 20
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    usluga.opis ?? 'Nema opis'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    usluga.opis ?? 'Nema opis',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              formatNumberToPrice(usluga.cijena),
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              formatNumberToMinutes(usluga.trajanjeUMin),
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              formatNumberToHours(usluga.rezultatUH),
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              usluga.dostupno == null
                                  ? 'Nepoznat'
                                  : usluga.dostupno == true
                                      ? 'Da'
                                      : 'Ne',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              usluga.dtKreiranja == null
                                  ? 'Nepoznat'
                                  : formatDateTime(usluga.dtKreiranja!) ??
                                      'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(Text(
                              usluga.dtZadnjeModifikacije == null
                                  ? 'Nema'
                                  : formatDateTime(
                                          usluga.dtZadnjeModifikacije!) ??
                                      'Nema',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              _buildOptionsForUsluga(context, usluga),
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

  Widget _buildOptionsForUsluga(BuildContext context, Usluga usluga) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_outlined),
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
      tooltip: 'Više opcija',
      onSelected: (value) async {
        switch (value) {
          case 'more_info':
            break;
          case 'edit':
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _buildDialogForUslugaEdit(usluga, context);
              },
            );
            break;
          case 'delete':
            /* await _buildLogicForTestDelete(context, test); */
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'more_info',
          child: Tooltip(
            message: 'Pregled usluge',
            child: Icon(Icons.remove_red_eye_outlined),
          ),
        ),
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
            message: 'Obriši uslugu',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogForUslugaEdit(Usluga usluga, BuildContext context) {
    String? _selectedImageBase64 = usluga.slika;
    Image? _selectedImage = usluga.slika != null && usluga.slika != ""
        ? imageFromBase64String(usluga.slika!)
        : null;
    return AlertDialog(
      title: const Text(
        'Izmjena podataka o usluzi',
        style: heading1,
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 800,
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderField(
                      builder: (field) {
                        return Container(
                          width: 300,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Slika',
                              border: InputBorder.none,
                            ),
                            child: Column(
                              children: [
                                if (_selectedImage != null)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 200,
                                      height: 150,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: _selectedImage,
                                      ),
                                    ),
                                  ),
                                ListTile(
                                  hoverColor: Colors.blue[700],
                                  tileColor: Colors.blue,
                                  iconColor: primaryWhiteTextColor,
                                  textColor: primaryWhiteTextColor,
                                  leading: const Icon(Icons.image_outlined),
                                  title: const Text('Odaberi sliku'),
                                  trailing:
                                      const Icon(Icons.file_upload_outlined),
                                  onTap: () async {
                                    var fileResult = await FilePicker.platform
                                        .pickFiles(type: FileType.image);
                                    if (fileResult == null ||
                                        fileResult.files.single.path == null) {
                                      return;
                                    }
                                    var image =
                                        File(fileResult.files.single.path!);

                                    if (await image.length() > maxSizeInBytes) {
                                      // ignore: use_build_context_synchronously
                                      showErrorDialog(context, 'Greška',
                                          'Veličina datoteke prelazi 2MB. Molimo odaberite manju datoteku.');
                                      return;
                                    }

                                    var base64Image =
                                        base64Encode(image.readAsBytesSync());
                                    setState(() {
                                      _selectedImage =
                                          imageFromBase64String(base64Image);
                                      _selectedImageBase64 = base64Image;
                                    });
                                    field.didChange(base64Image);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      name: 'slika'),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Naziv'),
                    name: 'naziv',
                    initialValue: usluga.naziv,
                    maxLength: 40,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Naziv je obavezan."),
                      FormBuilderValidators.maxLength(40)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Opis'),
                    name: 'opis',
                    initialValue: usluga.opis,
                    maxLines: 3,
                    minLines: 1,
                    maxLength: 1000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Opis je obavezan."),
                      FormBuilderValidators.maxLength(1000)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Cijena'),
                    name: 'cijena',
                    initialValue: usluga.cijena.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Cijena je obavezna."),
                      FormBuilderValidators.numeric(
                          errorText: "Unesite ispravnu cijenu."),
                      FormBuilderValidators.min(0.1,
                          errorText: "Cijena mora biti veća od 0."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                        labelText: 'Trajanje(u minutama)'),
                    name: 'trajanjeUMin',
                    initialValue: usluga.trajanjeUMin.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Trajanje(u minutama) je obavezno polje."),
                      FormBuilderValidators.numeric(
                          errorText: "Unesite ispravnu vrijednost."),
                      FormBuilderValidators.min(0.1,
                          errorText: "Vrijednost mora biti veća od 0."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Rezultat(u satima)'),
                    name: 'rezultatUH',
                    initialValue: usluga.rezultatUH.toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Rezultat(u satima) je obavezno polje."),
                      FormBuilderValidators.numeric(
                          errorText: "Unesite ispravnu vrijednost."),
                      FormBuilderValidators.min(0.1,
                          errorText: "Vrijednost mora biti veća od 0."),
                    ]),
                  ),
                  FormBuilderCheckbox(
                    name: 'dostupno',
                    initialValue: usluga.dostupno,
                    title: const Text('Dostupno'),
                    validator: FormBuilderValidators.required(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Testovi',
                      style: heading2,
                    ),
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
                        'Da li ste sigurni da želite izmijeniti podatke?');
                    if (!shouldProceed) return;

                    double? cijenaDouble = parseStringToDouble(
                        _formKey.currentState?.value['cijena']);
                    if (cijenaDouble == null) {
                      Navigator.of(context).pop();
                      makeErrorToast("Greška pri provjeri cijene.");
                      return;
                    }
                    double? rezultatUHDouble = parseStringToDouble(
                        _formKey.currentState?.value['rezultatUH']);
                    if (rezultatUHDouble == null) {
                      Navigator.of(context).pop();
                      makeErrorToast(
                          "Greška pri provjeri polja Rezultat(u satima).");
                      return;
                    }
                    int? trajanjeUMinInt = parseStringToInt(
                        _formKey.currentState?.value['trajanjeUMin']);
                    if (trajanjeUMinInt == null) {
                      Navigator.of(context).pop();
                      makeErrorToast(
                          "Greška pri provjeri polja Trajanje(u minutama).");
                      return;
                    }

                    UslugaRequest uslugaUpdateRequest = UslugaRequest(
                        naziv: _formKey.currentState?.value['naziv'],
                        opis: _formKey.currentState?.value['opis'],
                        cijena: cijenaDouble,
                        slika: _selectedImageBase64,
                        trajanjeUMin: trajanjeUMinInt,
                        rezultatUH: rezultatUHDouble,
                        dostupno:
                            _formKey.currentState?.value['dostupno'] as bool? ??
                                false);

                    await _uslugeProvider.update(
                        usluga.uslugaID!, uslugaUpdateRequest);

                    makeSuccessToast("Uspješno izmijenjeni podaci.");

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
}
