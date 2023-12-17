import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/novost/novost.dart';
import 'package:medlabo_desktop/models/novost/novost_request.dart';
import 'package:medlabo_desktop/models/obavijest/obavijest.dart';
import 'package:medlabo_desktop/models/obavijest/obavijest_request.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/providers/novosti_provider.dart';
import 'package:medlabo_desktop/providers/obavijesti_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/nums.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class NovostiIObavijestiScreen extends StatefulWidget {
  const NovostiIObavijestiScreen({super.key});

  @override
  State<NovostiIObavijestiScreen> createState() =>
      _NovostiIObavijestiScreenState();
}

class _NovostiIObavijestiScreenState extends State<NovostiIObavijestiScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
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
                child: NovostWidget(),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                child: ObavijestWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NovostWidget extends StatefulWidget {
  const NovostWidget({super.key});

  @override
  _NovostWidgetState createState() => _NovostWidgetState();
}

class _NovostWidgetState extends State<NovostWidget>
    with PaginationMixin<Novost> {
  late NovostiProvider _novostiProvider;
  SearchResult<Novost>? novosti;
  TextEditingController _novostSearchController = new TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  _NovostWidgetState() {
    itemsPerPage = 4;
  }

  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    initForm();
    fetchPage(currentPage);
  }

  Future initForm() async {
    var data = await _novostiProvider
        .get(filter: {'Page': 0, 'PageSize': itemsPerPage});
    if (mounted) {
      setState(() {
        novosti = data;
        totalItems = novosti!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _novostiProvider.get(filter: filter), 'Naslov');
    if (mounted) {
      setState(() {
        novosti = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: _buildNovostiHeader(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _buildNovostiDataTable(context),
        ),
      ],
    );
  }

  _buildNovostiHeader() {
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
                      text: 'Novosti',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryBlackTextColor))),
              RichText(
                  text: const TextSpan(
                      text: 'Novosti za pacijente',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: primaryDarkTextColor))),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: _buildNovostiHeaderSearch(),
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
                      return _buildDialogForNovostAdd(context);
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
                          text: 'Dodaj novost',
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

  _buildNovostiDataTable(BuildContext context) {
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
                        message: 'Slika za prikaz novosti',
                        child: Text(
                          'Slika',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(
                          label: Tooltip(
                        message: 'Naslov novosti',
                        child: Text(
                          'Naslov',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(
                          label: Tooltip(
                        message: 'Tekst novosti',
                        child: Text(
                          'Sadržaj',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(label: Text('Opcije')),
                    ],
                    rows: novosti != null
                        ? novosti!.result
                            .map((novost) => DataRow(cells: [
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (novost.slika != null &&
                                                novost.slika != "") {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    child: Container(
                                                      width: 600,
                                                      height: 600,
                                                      child:
                                                          imageFromBase64String(
                                                              novost.slika!),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: novost.slika != null &&
                                                  novost.slika != ""
                                              ? imageFromBase64String(
                                                  novost.slika!)
                                              : const Text('Nema slike'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 200.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          (novost.naslov?.length ?? 0) > 22
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          novost.naslov ??
                                                              'Nema naslov'),
                                                    );
                                                  },
                                                )
                                              : null;
                                        },
                                        child: Text(
                                          novost.naslov ?? 'Nema naslov',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 600.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          (novost.sadrzaj?.length ?? 0) > 80
                                              ? showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxHeight:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.7,
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(novost
                                                                  .sadrzaj ??
                                                              'Nema sadrzaj'),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : null;
                                        },
                                        child: Text(
                                          novost.sadrzaj ?? 'Nema sadrzaj',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    _buildOptionsForNovost(context, novost),
                                  ),
                                ]))
                            .toList()
                        : []),
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

  _buildNovostiHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi novost...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _novostSearchController,
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

  _buildDialogForNovostAdd(BuildContext context) {
    String? _selectedImageBase64;
    return AlertDialog(
      title: const Text(
        'Dodavanje novosti',
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
                          decoration: InputDecoration(
                            labelText: 'Slika',
                            border: InputBorder.none,
                            errorText: field.errorText,
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
                    name: 'slika',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Slika je obavezna."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Naslov'),
                    name: 'naslov',
                    maxLength: 100,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Naslov je obavezan."),
                      FormBuilderValidators.maxLength(100)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Sadržaj'),
                    name: 'sadrzaj',
                    maxLines: 7,
                    minLines: 1,
                    maxLength: 10000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Sadržaj je obavezan."),
                      FormBuilderValidators.maxLength(10000)
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
                        'Da li ste sigurni da želite kreirati novost?');
                    if (!shouldProceed) return;

                    NovostRequest novostInsertRequest = NovostRequest(
                      naslov: _formKey.currentState?.value['naslov'],
                      sadrzaj: _formKey.currentState?.value['sadrzaj'],
                      slika: _formKey.currentState?.value['slika'],
                    );

                    await _novostiProvider.insert(novostInsertRequest);

                    makeSuccessToast("Uspješno dodana novost.");

                    fetchPage(currentPage);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Kreiraj novost',
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

  Widget _buildOptionsForNovost(BuildContext context, Novost novost) {
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
              barrierDismissible: true,
              builder: (context) {
                return _buildDialogForNovostEdit(context, novost);
              },
            );
            break;
          case 'delete':
            await _buildLogicForNovostDelete(context, novost);
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
            message: 'Obriši novost',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogForNovostEdit(BuildContext context, Novost novost) {
    String? _selectedImageBase64 = novost.slika;
    Image? _selectedImage = novost.slika != null && novost.slika != ""
        ? imageFromBase64String(novost.slika!)
        : null;
    return AlertDialog(
      title: const Text(
        'Izmjena novosti',
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
                    initialValue: _selectedImageBase64,
                    builder: (field) {
                      return Container(
                        width: 300,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Slika',
                            border: InputBorder.none,
                            errorText: field.errorText,
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
                    name: 'slika',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Slika je obavezna."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Naslov'),
                    name: 'naslov',
                    initialValue: novost.naslov,
                    maxLength: 100,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Naslov je obavezan."),
                      FormBuilderValidators.maxLength(40)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Sadržaj'),
                    name: 'sadrzaj',
                    initialValue: novost.sadrzaj,
                    maxLines: 7,
                    minLines: 1,
                    maxLength: 10000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Sadržaj je obavezan."),
                      FormBuilderValidators.maxLength(10000)
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
                        'Da li ste sigurni da želite izmijeniti podatke?');
                    if (!shouldProceed) return;

                    NovostRequest novostUpdateRequest = NovostRequest(
                      naslov: _formKey.currentState?.value['naslov'],
                      sadrzaj: _formKey.currentState?.value['sadrzaj'],
                      slika: _selectedImageBase64,
                    );

                    await _novostiProvider.update(
                        novost.novostID!, novostUpdateRequest);

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

  _buildLogicForNovostDelete(BuildContext context, Novost novost) async {
    if (!await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite obrisati ovu novost?')) {
      return;
    }
    await _novostiProvider.delete(novost.novostID!);
    makeSuccessToast('Uspješno obrisana novost.');
    fetchPage(currentPage);
  }
}

//OBAVIJESTI--------------------------------------------------------------------------------------------------------

class ObavijestWidget extends StatefulWidget {
  const ObavijestWidget({super.key});

  @override
  _ObavijestWidgetState createState() => _ObavijestWidgetState();
}

class _ObavijestWidgetState extends State<ObavijestWidget>
    with PaginationMixin<Obavijest> {
  late ObavijestiProvider _obavijestiProvider;
  SearchResult<Obavijest>? obavijesti;
  final TextEditingController _obavijestSearchController =
      TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  _ObavijestWidgetState() {
    itemsPerPage = 4;
  }

  @override
  void initState() {
    super.initState();
    _obavijestiProvider = context.read<ObavijestiProvider>();
    initForm();
    fetchPage(currentPage);
  }

  Future initForm() async {
    var data = await _obavijestiProvider
        .get(filter: {'Page': 0, 'PageSize': itemsPerPage});
    if (mounted) {
      setState(() {
        obavijesti = data;
        totalItems = obavijesti!.count;
      });
    }
  }

  void fetchPage(int page) async {
    var result = await fetchData(
        page, (filter) => _obavijestiProvider.get(filter: filter), 'Naslov');
    if (mounted) {
      setState(() {
        obavijesti = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: _buildObavijestiHeader(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _buildObavijestiDataTable(context),
        ),
      ],
    );
  }

  _buildObavijestiHeader() {
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
                      text: 'Obavijesti',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryBlackTextColor))),
              RichText(
                  text: const TextSpan(
                      text: 'Obavijesti za osoblje',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: primaryDarkTextColor))),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: _buildObavijestiHeaderSearch(),
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
                      return _buildDialogForObavijestAdd(context);
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
                          text: 'Dodaj obavijest',
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

  _buildObavijestiHeaderSearch() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pronađi obavijest...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: _obavijestSearchController,
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

  _buildDialogForObavijestAdd(BuildContext context) {
    String? _selectedImageBase64;
    return AlertDialog(
      title: const Text(
        'Dodavanje obavijesti',
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
                          decoration: InputDecoration(
                            labelText: 'Slika',
                            border: InputBorder.none,
                            errorText: field.errorText,
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
                    name: 'slika',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Slika je obavezna."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Naslov'),
                    name: 'naslov',
                    maxLength: 100,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Naslov je obavezan."),
                      FormBuilderValidators.maxLength(100)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Sadržaj'),
                    name: 'sadrzaj',
                    maxLines: 7,
                    minLines: 1,
                    maxLength: 10000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Sadržaj je obavezan."),
                      FormBuilderValidators.maxLength(10000)
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
                        'Da li ste sigurni da želite kreirati obavijest?');
                    if (!shouldProceed) return;

                    ObavijestRequest obavijestInsertRequest = ObavijestRequest(
                      naslov: _formKey.currentState?.value['naslov'],
                      sadrzaj: _formKey.currentState?.value['sadrzaj'],
                      slika: _formKey.currentState?.value['slika'],
                    );

                    await _obavijestiProvider.insert(obavijestInsertRequest);

                    makeSuccessToast("Uspješno dodana obavijest.");

                    fetchPage(currentPage);

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Kreiraj obavijest',
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

  _buildObavijestiDataTable(BuildContext context) {
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
                        message: 'Slika za prikaz obavijesti',
                        child: Text(
                          'Slika',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(
                          label: Tooltip(
                        message: 'Naslov obavijesti',
                        child: Text(
                          'Naslov',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(
                          label: Tooltip(
                        message: 'Tekst obavijesti',
                        child: Text(
                          'Sadržaj',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      DataColumn(label: Text('Opcije')),
                    ],
                    rows: obavijesti != null
                        ? obavijesti!.result
                            .map((obavijest) => DataRow(cells: [
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (obavijest.slika != null &&
                                                obavijest.slika != "") {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    child: Container(
                                                      width: 600,
                                                      height: 600,
                                                      child:
                                                          imageFromBase64String(
                                                              obavijest.slika!),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: obavijest.slika != null &&
                                                  obavijest.slika != ""
                                              ? imageFromBase64String(
                                                  obavijest.slika!)
                                              : const Text('Nema slike'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 200.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          (obavijest.naslov?.length ?? 0) > 22
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          obavijest.naslov ??
                                                              'Nema naslov'),
                                                    );
                                                  },
                                                )
                                              : null;
                                        },
                                        child: Text(
                                          obavijest.naslov ?? 'Nema naslov',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 600.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          (obavijest.sadrzaj?.length ?? 0) > 80
                                              ? showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxHeight:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.7,
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(obavijest
                                                                  .sadrzaj ??
                                                              'Nema sadrzaj'),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : null;
                                        },
                                        child: Text(
                                          obavijest.sadrzaj ?? 'Nema sadrzaj',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    _buildOptionsForObavijest(
                                        context, obavijest),
                                  ),
                                ]))
                            .toList()
                        : []),
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

  Widget _buildOptionsForObavijest(BuildContext context, Obavijest obavijest) {
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
              barrierDismissible: true,
              builder: (context) {
                return _buildDialogForObavijestEdit(context, obavijest);
              },
            );
            break;
          case 'delete':
            await _buildLogicForObavijestDelete(context, obavijest);
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
            message: 'Obriši obavijest',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogForObavijestEdit(
      BuildContext context, Obavijest obavijest) {
    String? _selectedImageBase64 = obavijest.slika;
    Image? _selectedImage = obavijest.slika != null && obavijest.slika != ""
        ? imageFromBase64String(obavijest.slika!)
        : null;
    return AlertDialog(
      title: const Text(
        'Izmjena obavijesti',
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
                    initialValue: _selectedImageBase64,
                    builder: (field) {
                      return Container(
                        width: 300,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Slika',
                            border: InputBorder.none,
                            errorText: field.errorText,
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
                    name: 'slika',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Slika je obavezna."),
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Naslov'),
                    name: 'naslov',
                    initialValue: obavijest.naslov,
                    maxLength: 100,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Naslov je obavezan."),
                      FormBuilderValidators.maxLength(40)
                    ]),
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Sadržaj'),
                    name: 'sadrzaj',
                    initialValue: obavijest.sadrzaj,
                    maxLines: 7,
                    minLines: 1,
                    maxLength: 10000,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10000),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Sadržaj je obavezan."),
                      FormBuilderValidators.maxLength(10000)
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
                        'Da li ste sigurni da želite izmijeniti podatke?');
                    if (!shouldProceed) return;

                    ObavijestRequest obavijestUpdateRequest = ObavijestRequest(
                      naslov: _formKey.currentState?.value['naslov'],
                      sadrzaj: _formKey.currentState?.value['sadrzaj'],
                      slika: _selectedImageBase64,
                    );

                    await _obavijestiProvider.update(
                        obavijest.obavijestID!, obavijestUpdateRequest);

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

  _buildLogicForObavijestDelete(
      BuildContext context, Obavijest obavijest) async {
    if (!await showConfirmationDialog(context, 'Potvrda',
        'Da li ste sigurni da želite obrisati ovu obavijest?')) {
      return;
    }
    await _obavijestiProvider.delete(obavijest.obavijestID!);
    makeSuccessToast('Uspješno obrisana obavijest.');
    fetchPage(currentPage);
  }
}
