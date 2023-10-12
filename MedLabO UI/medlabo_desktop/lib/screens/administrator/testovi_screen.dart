import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/test/test.dart';
import 'package:medlabo_desktop/models/test/test_request.dart';
import 'package:medlabo_desktop/models/test_parametar/test_parametar.dart';
import 'package:medlabo_desktop/models/test_parametar/test_parametar_request.dart';
import 'package:medlabo_desktop/providers/test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_and_test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/nums.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class TestoviScreen extends StatefulWidget {
  const TestoviScreen({super.key});

  @override
  State<TestoviScreen> createState() => _TestoviScreenState();
}

class _TestoviScreenState extends State<TestoviScreen>
    with PaginationMixin<Test> {
  late TestoviProvider _testoviProvider;
  late TestParametriProvider _testParametriProvider;
  late TestoviAndTestParametriProvider _testoviAndTestParametriProvider;
  SearchResult<Test>? testovi;
  TextEditingController _testSearchController = new TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _testoviProvider = context.read<TestoviProvider>();
    initForm();
    fetchPage(currentPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _testParametriProvider = context.read<TestParametriProvider>();
    _testoviAndTestParametriProvider =
        context.read<TestoviAndTestParametriProvider>();
  }

  Future initForm() async {
    var data = await _testoviProvider
        .get(filter: {'Page': 0, 'PageSize': itemsPerPage});
    if (mounted) {
      setState(() {
        testovi = data;
        totalItems = testovi!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _testoviProvider.get(filter: filter), 'Naziv');
    setState(() {
      testovi = result;
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
                child: _buildTestoviHeader(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: _buildTestoviDataTable(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTestoviDataTable(BuildContext context) {
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
                      message: 'Ime testa',
                      child: Text(
                        'Naziv',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Kratak opis testa',
                      child: Text(
                        'Opis',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Cijena jednog testa',
                      child: Text(
                        'Cijena',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message:
                          'Upute koje se trebaju slijediti prije dolaska na test',
                      child: Text(
                        'Napomena za pripremu',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(
                        label: Tooltip(
                      message: 'Datum kada je kreiran test',
                      child: Text(
                        'Datum kreiranja',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    DataColumn(label: Text('Opcije')),
                  ],
                  rows: testovi != null
                      ? testovi!.result.map((test) {
                          return DataRow(cells: [
                            DataCell(
                              SizedBox(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (test.naziv?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    test.naziv ?? 'Nema naziv'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    test.naziv ?? 'Nema naziv',
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
                                    (test.opis?.length ?? 0) > 20
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    test.opis ?? 'Nema opis'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    test.opis ?? 'Nema opis',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              formatNumberToPrice(test.cijena),
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              SizedBox(
                                width: 150.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (test.napomenaZaPripremu?.length ?? 0) > 20
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    test.napomenaZaPripremu ??
                                                        'Nema napomenu'),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                  child: Text(
                                    test.napomenaZaPripremu ?? 'Nema napomenu',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(
                              test.dtKreiranja == null
                                  ? 'Nepoznat'
                                  : formatDateTime(test.dtKreiranja!) ??
                                      'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              _buildOptionsForTest(context, test),
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

  PopupMenuButton<String> _buildOptionsForTest(
      BuildContext context, Test test) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_outlined),
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
      tooltip: 'Više opcija',
      onSelected: (value) async {
        var testParametar =
            await _testParametriProvider.getById(test.testParametarID!);
        switch (value) {
          case 'more_info':
            break;
          case 'edit':
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _buildDialogForTestEdit(test, testParametar, context);
              },
            );
            break;
          case 'delete':
            await _buildLogicForTestDelete(context, test);
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'more_info',
          child: Tooltip(
            message: 'Pregled testa',
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
            message: 'Obriši test',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  AlertDialog _buildDialogForTestEdit(
      Test test, TestParametar? testParametar, BuildContext context) {
    String? _selectedImageBase64 = test.slika;
    Image? _selectedImage = test.slika != null && test.slika != ""
        ? imageFromBase64String(test.slika!)
        : null;
    return AlertDialog(
      title: const Text(
        'Izmjena podataka o testu',
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
                    initialValue: test.naziv,
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
                    initialValue: test.opis,
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
                    decoration: const InputDecoration(
                        labelText: 'Napomena za pripremu'),
                    name: 'napomenaZaPripremu',
                    initialValue: test.napomenaZaPripremu,
                    maxLines: 2,
                    minLines: 1,
                    maxLength: 200,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Tip uzorka'),
                    name: 'tipUzorka',
                    initialValue: test.tipUzorka,
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(60),
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Cijena'),
                    name: 'cijena',
                    initialValue: test.cijena.toString(),
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
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Parametri',
                      style: heading2,
                    ),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                        labelText: 'Minimalna vrijednost'),
                    name: 'minVrijednost',
                    initialValue:
                        testParametar?.minVrijednost?.toString() ?? '',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                        labelText: 'Maksimalna vrijednost'),
                    name: 'maxVrijednost',
                    initialValue:
                        testParametar?.maxVrijednost?.toString() ?? '',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Normalna vrijednost'),
                    name: 'normalnaVrijednost',
                    initialValue: testParametar?.normalnaVrijednost,
                    inputFormatters: [LengthLimitingTextInputFormatter(60)],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Jedinica'),
                    name: 'jedinica',
                    initialValue: testParametar?.jedinica,
                    inputFormatters: [LengthLimitingTextInputFormatter(60)],
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

                    TestRequest testUpdateRequest = TestRequest(
                        naziv: _formKey.currentState?.value['naziv'],
                        opis: _formKey.currentState?.value['opis'],
                        cijena: cijenaDouble,
                        slika: _selectedImageBase64,
                        napomenaZaPripremu:
                            _formKey.currentState?.value['napomenaZaPripremu'],
                        tipUzorka: _formKey.currentState?.value['tipUzorka'],
                        testParametarID: test.testParametarID);

                    double? minVrijednostDouble =
                        _formKey.currentState?.value['minVrijednost'] != null &&
                                _formKey.currentState?.value['minVrijednost'] !=
                                    ""
                            ? parseStringToDouble(
                                _formKey.currentState?.value['minVrijednost'])
                            : null;

                    double? maxVrijednostDouble =
                        _formKey.currentState?.value['maxVrijednost'] != null &&
                                _formKey.currentState?.value['maxVrijednost'] !=
                                    ""
                            ? parseStringToDouble(
                                _formKey.currentState?.value['maxVrijednost'])
                            : null;

                    TestParametarRequest testParametarUpdateRequest =
                        TestParametarRequest(
                            minVrijednost: minVrijednostDouble,
                            maxVrijednost: maxVrijednostDouble,
                            normalnaVrijednost: _formKey
                                .currentState?.value['normalnaVrijednost'],
                            jedinica: _formKey.currentState?.value['jedinica']);

                    await _testoviAndTestParametriProvider
                        .updateTestAndTestParameter(
                            test.testID!,
                            testUpdateRequest,
                            testParametar!.testParametarID!,
                            testParametarUpdateRequest);

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

  AlertDialog _buildDialogForTestAdd(BuildContext context) {
    String? _selectedImageBase64;
    return AlertDialog(
      title: const Text(
        'Dodavanje novog testa',
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
                                if (_selectedImageBase64 != null)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 200,
                                      height: 150,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: imageFromBase64String(
                                            _selectedImageBase64!),
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
                    decoration: const InputDecoration(
                        labelText: 'Napomena za pripremu'),
                    name: 'napomenaZaPripremu',
                    maxLines: 2,
                    minLines: 1,
                    maxLength: 200,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Tip uzorka'),
                    name: 'tipUzorka',
                    maxLength: 60,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(60),
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Cijena'),
                    name: 'cijena',
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
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Parametri',
                      style: heading2,
                    ),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                        labelText: 'Minimalna vrijednost'),
                    name: 'minVrijednost',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                        labelText: 'Maksimalna vrijednost'),
                    name: 'maxVrijednost',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                  FormBuilderTextField(
                    decoration:
                        const InputDecoration(labelText: 'Normalna vrijednost'),
                    name: 'normalnaVrijednost',
                    inputFormatters: [LengthLimitingTextInputFormatter(60)],
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Jedinica'),
                    name: 'jedinica',
                    inputFormatters: [LengthLimitingTextInputFormatter(60)],
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
                        'Da li ste sigurni da želite kreirati novi test?');
                    if (!shouldProceed) return;

                    double? cijenaDouble = parseStringToDouble(
                        _formKey.currentState?.value['cijena']);
                    if (cijenaDouble == null) {
                      Navigator.of(context).pop();
                      makeErrorToast("Greška pri provjeri cijene.");
                      return;
                    }

                    TestRequest testUpdateRequest = TestRequest(
                      naziv: _formKey.currentState?.value['naziv'],
                      opis: _formKey.currentState?.value['opis'],
                      cijena: cijenaDouble,
                      slika: _formKey.currentState?.value['slika'],
                      napomenaZaPripremu:
                          _formKey.currentState?.value['napomenaZaPripremu'],
                      tipUzorka: _formKey.currentState?.value['tipUzorka'],
                    );

                    double? minVrijednostDouble =
                        _formKey.currentState?.value['minVrijednost'] != null &&
                                _formKey.currentState?.value['minVrijednost'] !=
                                    ""
                            ? parseStringToDouble(
                                _formKey.currentState?.value['minVrijednost'])
                            : null;

                    double? maxVrijednostDouble =
                        _formKey.currentState?.value['maxVrijednost'] != null &&
                                _formKey.currentState?.value['maxVrijednost'] !=
                                    ""
                            ? parseStringToDouble(
                                _formKey.currentState?.value['maxVrijednost'])
                            : null;

                    TestParametarRequest testParametarUpdateRequest =
                        TestParametarRequest(
                            minVrijednost: minVrijednostDouble,
                            maxVrijednost: maxVrijednostDouble,
                            normalnaVrijednost: _formKey
                                .currentState?.value['normalnaVrijednost'],
                            jedinica: _formKey.currentState?.value['jedinica']);

                    await _testoviAndTestParametriProvider
                        .insertTestAndTestParameter(
                            testUpdateRequest, testParametarUpdateRequest);

                    makeSuccessToast("Uspješno dodan test.");

                    fetchPage(currentPage);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Kreiraj test',
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

  Row _buildTestoviHeader() {
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
                      text: 'Testovi',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryBlackTextColor))),
              RichText(
                  text: const TextSpan(
                      text: 'Pojedinačni testovi',
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
            child: _buildTestoviHeaderSearch(),
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
                      return _buildDialogForTestAdd(context);
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
                          text: 'Dodaj test',
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

  SizedBox _buildTestoviHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi test...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _testSearchController,
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

  Future _buildLogicForTestDelete(BuildContext context, Test test) async {
    if (!await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite obrisati ovaj test?')) {
      return;
    }
    await _testoviAndTestParametriProvider.deleteTestAndTestParameter(
        test.testID!, test.testParametarID!);
    makeSuccessToast('Uspješno obrisan test.');
    fetchPage(currentPage);
  }
}
