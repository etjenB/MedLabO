import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/providers/medicinsko_osoblje_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
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
    var data = await _medicinskoOsobljeProvider
        .get(filter: {'Page': 0, 'PageSize': itemsPerPage});
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
        'ImePrezime');
    setState(() {
      medicinskoOsoblje = result;
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
                          color: primaryDarkTextColor))),
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
                ))),
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

  _buildDialogForUposlenikAdd(BuildContext context) {}

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
                                  ? 'Nepoznat'
                                  : formatDateTime(
                                          medOso.dtPrekidRadnogOdnosa!) ??
                                      'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(medOso.spol == null
                                ? const Text(
                                    'Nepoznat',
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
                                        medOso.spol!,
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
                return Text('Dolari');
                //return _buildDialogForMedicinskoOsobljeEdit(medOso, context);
              },
            );
            break;
          case 'delete':
            //await _buildLogicForMedicinskoOsobljeDelete(context, medOso);
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
            message: 'Obriši račun uposlenika',
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }
}
