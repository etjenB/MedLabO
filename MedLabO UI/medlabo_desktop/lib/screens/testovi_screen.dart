import 'package:flutter/material.dart';
import 'package:medlabo_desktop/utils/constants/desing.dart';
import 'package:provider/provider.dart';
import '../providers/testovi_provider.dart';

class TestoviScreen extends StatefulWidget {
  const TestoviScreen({super.key});

  @override
  State<TestoviScreen> createState() => _TestoviScreenState();
}

class _TestoviScreenState extends State<TestoviScreen> {
  late TestoviProvider _testoviProvider;

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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
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
                                    color: primaryDarkTextColor))),
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
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Container(
                            width: 300,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Pronađi test...',
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add,
                                    color: primaryLightTextColor),
                                const SizedBox(width: 8),
                                RichText(
                                  text: const TextSpan(
                                    text: 'Dodaj test',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: primaryLightTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Naziv',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Opis',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Cijena',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Napomena za pripremu',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Datum kreiranja',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                          Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Opcije',
                                        style: TextStyle(
                                            color: primaryDarkTextColor,
                                            fontWeight: FontWeight.bold))),
                              )),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  //Navigator.of(context).pop();
                  var data = await _testoviProvider.get();
                  print('data: ${data?.result[0].naziv}');
                },
                child: Text('GET TESTOVE')),
          ],
        ),
      ),
    );
  }
}
