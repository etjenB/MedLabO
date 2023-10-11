import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:medlabo_desktop/models/novost/novost.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/providers/novosti_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:provider/provider.dart';

class NovostiIObavijestiScreen extends StatefulWidget {
  const NovostiIObavijestiScreen({super.key});

  @override
  State<NovostiIObavijestiScreen> createState() =>
      _NovostiIObavijestiScreenState();
}

class _NovostiIObavijestiScreenState extends State<NovostiIObavijestiScreen> {
  late NovostiProvider _novostiProvider;
  SearchResult<Novost>? novosti;
  TextEditingController _novostSearchController = new TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    initForm();
  }

  Future initForm() async {
    var data = await _novostiProvider.get();
    if (mounted) {
      setState(() {
        novosti = data;
      });
    }
  }

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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                ),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                ),
              ),
            ),
          ),
        ],
      ),
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
          child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => tableHeaderColor),
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
                              Container(
                                width: 50,
                                height: 50,
                                child: GestureDetector(
                                  onTap: () {},
                                  child:
                                      novost.slika != null && novost.slika != ""
                                          ? imageFromBase64String(novost.slika!)
                                          : const Text('Nema slike'),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (novost.naslov?.length ?? 0) > 12
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(novost.naslov ??
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
                                width: 300.0,
                                child: GestureDetector(
                                  onTap: () {
                                    (novost.sadrzaj?.length ?? 0) > 50
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(novost.sadrzaj ??
                                                    'Nema sadrzaj'),
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
          var data = await _novostiProvider
              .get(filter: {'Naslov': _novostSearchController.text});

          setState(() {
            novosti = data;
          });
        },
        onChanged: (value) async {
          if (value.isEmpty) {
            var data = await _novostiProvider.get();

            setState(() {
              novosti = data;
            });
          }
        },
      ),
    );
  }

  _buildDialogForNovostAdd(BuildContext context) {}

  Widget _buildOptionsForNovost(BuildContext context, Novost novost) {
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

  Widget _buildDialogForNovostEdit(BuildContext context, Novost novost) {
    return const AlertDialog(
        title: Text(
          'Izmjena podataka o novosti',
          style: heading1,
        ),
        content: Text('Testiranje'));
  }

  _buildLogicForNovostDelete(BuildContext context, Novost novost) {}

  _buildObavijestiHeader() {}

  _buildObavijestiDataTable(BuildContext context) {}
}
