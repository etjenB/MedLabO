import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/test.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:provider/provider.dart';
import '../providers/testovi_provider.dart';

class TestoviScreen extends StatefulWidget {
  const TestoviScreen({super.key});

  @override
  State<TestoviScreen> createState() => _TestoviScreenState();
}

class _TestoviScreenState extends State<TestoviScreen> {
  late TestoviProvider _testoviProvider;
  SearchResult<Test>? testovi;
  TextEditingController _testSearchController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _testoviProvider = context.read<TestoviProvider>();
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
              ElevatedButton(
                  onPressed: () async {
                    var data = await _testoviProvider.get();

                    setState(() {
                      testovi = data;
                    });

                    print('data: ${data?.result[0].naziv}');
                  },
                  child: const Text('GET TESTOVE')),
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
          child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => tableHeaderColor),
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
                  ? testovi!.result
                      .map((test) => DataRow(cells: [
                            DataCell(Text(
                              test.naziv ?? 'Nema naziv',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  (test.opis?.length ?? 0) > 50
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
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            DataCell(Text(
                              formatNumberToPrice(test.cijena),
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  (test.napomenaZaPripremu?.length ?? 0) > 50
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
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            DataCell(Text(
                              test.dtKreiranja ?? 'Nepoznat',
                              overflow: TextOverflow.fade,
                            )),
                            DataCell(
                              _buildOptionsForTest(context, test),
                            ),
                          ]))
                      .toList()
                  : []),
        ),
      ],
    );
  }

  PopupMenuButton<String> _buildOptionsForTest(
      BuildContext context, Test test) {
    final TextEditingController _testNazivController =
        TextEditingController(text: test.naziv);
    final TextEditingController _testOpisController =
        TextEditingController(text: test.opis);
    final TextEditingController _testNapomentaZaPripremuController =
        TextEditingController(text: test.napomenaZaPripremu);
    final TextEditingController _testTipUzorkaController =
        TextEditingController(text: test.tipUzorka);
    final TextEditingController _testCijenaController = TextEditingController(
        text: test.cijena != null ? test.cijena!.toString() : "");

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_outlined),
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
      tooltip: 'Više opcija',
      onSelected: (value) {
        switch (value) {
          case 'edit':
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Izmjena podataka o testu'),
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      width: 800,
                      child: Column(
                        children: [
                          test.slika != ""
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: imageFromBase64String(test.slika!),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    alignment: Alignment.center,
                                    color: Colors.red[400],
                                    child: const Text(
                                      'Ne postoji slika',
                                      style: TextStyle(
                                          color: primaryWhiteTextColor),
                                    ),
                                  ),
                                ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Naziv',
                            ),
                            controller: _testNazivController,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Opis',
                            ),
                            controller: _testOpisController,
                            maxLines: 3,
                            minLines: 1,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Napomena za pripremu',
                            ),
                            controller: _testNapomentaZaPripremuController,
                            maxLines: 2,
                            minLines: 1,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Tip uzorka',
                            ),
                            controller: _testTipUzorkaController,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Cijena',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*'))
                            ],
                            controller: _testCijenaController,
                          ),
                        ],
                      ),
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
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)),
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
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green)),
                              onPressed: () {
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
              },
            );
            break;
          case 'delete':
            break;
          case 'more_info':
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Icon(Icons.edit),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Icon(Icons.delete),
        ),
        const PopupMenuItem(
          value: 'more_info',
          child: Icon(Icons.info_outline),
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
                onPressed: () {},
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
          var data = await _testoviProvider
              .get(filter: {'Naziv': _testSearchController.text});

          setState(() {
            testovi = data;
          });
        },
        onChanged: (value) async {
          if (value.isEmpty) {
            var data = await _testoviProvider.get();

            setState(() {
              testovi = data;
            });
          }
        },
      ),
    );
  }
}
