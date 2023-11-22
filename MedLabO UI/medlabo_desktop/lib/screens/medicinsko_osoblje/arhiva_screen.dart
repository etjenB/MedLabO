import 'package:flutter/material.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/models/test/test.dart';
import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/providers/termini_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';
import 'package:medlabo_desktop/providers/usluge_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/pagination_mixin.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:medlabo_desktop/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class ArhivaScreen extends StatefulWidget {
  const ArhivaScreen({super.key});

  @override
  State<ArhivaScreen> createState() => _ArhivaScreenScreenState();
}

class _ArhivaScreenScreenState extends State<ArhivaScreen> {
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
                child: ArhivaWidget(),
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
                child: ObrisaniTerminiWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArhivaWidget extends StatefulWidget {
  const ArhivaWidget({super.key});

  @override
  State<ArhivaWidget> createState() => ArhivaWidgetState();
}

class ArhivaWidgetState extends State<ArhivaWidget>
    with PaginationMixin<Termin> {
  late TerminiProvider _terminiProvider;
  SearchResult<Termin>? termini;
  TextEditingController _terminSearchController = new TextEditingController();
  late TestoviProvider _testoviProvider;
  late UslugeProvider _uslugeProvider;

  ArhivaWidgetState() {
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
      'Finaliziran': true,
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
      'Finaliziran': true,
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
            child: _buildArhivaHeader(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                      "${termini!.result[index].pacijent?.ime ?? 'Nema imena'} ${termini!.result[index].pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termini!.result[index].dtTermina!)}"),
                                )
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return FutureBuilder<Widget>(
                                    future: _buildDialogForArhivaTerminPreview(
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

  _buildArhivaHeader() {
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
                      text: 'Arhiva termina',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryWhiteTextColor),
                    ),
                  ),
                  const Tooltip(
                    message:
                        'Tabela termina u kojoj se nalaze svi u potpunosti obrađeni termini.',
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
            child: _buildArhivaHeaderSearch(),
          ),
        ),
      ],
    );
  }

  _buildArhivaHeaderSearch() {
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

  Future<Widget> _buildDialogForArhivaTerminPreview(
      BuildContext context, Termin termin) async {
    List<Usluga>? usluge =
        await _uslugeProvider.getTestoviByTerminId(termin.terminID!);
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
                            "Datum rođenja: ${termin.pacijent?.datumRodjenja == null ? 'Nepoznato' : formatDateTime(termin.pacijent!.datumRodjenja!)}"),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ObrisaniTerminiWidget extends StatefulWidget {
  const ObrisaniTerminiWidget({super.key});

  @override
  State<ObrisaniTerminiWidget> createState() => ObrisaniTerminiWidgetState();
}

class ObrisaniTerminiWidgetState extends State<ObrisaniTerminiWidget>
    with PaginationMixin<Termin> {
  late TerminiProvider _terminiProvider;
  SearchResult<Termin>? termini;
  TextEditingController _terminSearchController = new TextEditingController();
  late TestoviProvider _testoviProvider;
  late UslugeProvider _uslugeProvider;

  ObrisaniTerminiWidgetState() {
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
      'Obrisan': true,
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
      'Obrisan': true,
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
            child: _buildObrisaniTerminiHeader(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                      "${termini!.result[index].pacijent?.ime ?? 'Nema imena'} ${termini!.result[index].pacijent?.prezime ?? 'Nema prezimena'} - ${formatDateTime(termini!.result[index].dtTermina!)}"),
                                )
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return FutureBuilder<Widget>(
                                    future:
                                        _buildDialogForObrisaniTerminiTerminPreview(
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

  _buildObrisaniTerminiHeader() {
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
                      text: 'Obrisani termini',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: primaryWhiteTextColor),
                    ),
                  ),
                  const Tooltip(
                    message:
                        'Tabela termina u kojoj se nalaze svi obrisani termini.',
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
            child: _buildObrisaniTerminiHeaderSearch(),
          ),
        ),
      ],
    );
  }

  _buildObrisaniTerminiHeaderSearch() {
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

  Future<Widget> _buildDialogForObrisaniTerminiTerminPreview(
      BuildContext context, Termin termin) async {
    List<Usluga>? usluge =
        await _uslugeProvider.getTestoviByTerminId(termin.terminID!);
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
                            "Datum rođenja: ${termin.pacijent?.datumRodjenja == null ? 'Nepoznato' : formatDateTime(termin.pacijent!.datumRodjenja!)}"),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
