import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_mobile/models/cart/cart.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/screens/novi_termin_screen/odabir_termina_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class NoviTerminScreen extends StatefulWidget {
  const NoviTerminScreen({super.key});

  @override
  State<NoviTerminScreen> createState() => _NoviTerminScreenState();
}

class _NoviTerminScreenState extends State<NoviTerminScreen> {
  UslugeProvider? _uslugeProvider;
  late TestoviProvider _testoviProvider;
  static const _pageSize = 6;
  final TextEditingController _uslugaSearchController = TextEditingController();
  final PagingController<int, Usluga> _uslugePagingController =
      PagingController(firstPageKey: 0);
  List<Usluga>? usluge;

  @override
  void initState() {
    _testoviProvider = context.read<TestoviProvider>();
    _uslugePagingController.addPageRequestListener((pageKey) {
      _fetchPageUsluge(pageKey);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_uslugeProvider == null) {
      _uslugeProvider = context.read<UslugeProvider>();
      initForm();
    }
  }

  Future initForm() async {
    if (_uslugeProvider == null) return;

    var cart = Provider.of<Cart>(context, listen: true);
    var chosenUsluge = cart.getAllUslugaItems();
    if (chosenUsluge.isEmpty) {
      setState(() {
        usluge = [];
      });
      return;
    }
    var data = await _uslugeProvider!.recommend(chosenUsluge.last.id);
    setState(() {
      usluge = data;
    });
  }

  Future<void> _fetchPageUsluge(int pageKey, {String? searchValue = ""}) async {
    if (_uslugeProvider == null) return;

    try {
      final newItems = await _uslugeProvider!.get(
        filter: {
          'Page': pageKey,
          'PageSize': _pageSize,
          'Naziv': searchValue,
        },
      );
      final isLastPage = newItems.result.length < _pageSize;
      if (!mounted) return;
      if (isLastPage) {
        _uslugePagingController.appendLastPage(newItems.result);
      } else {
        final nextPageKey = pageKey + 1;
        _uslugePagingController.appendPage(newItems.result, nextPageKey);
      }
    } catch (error) {
      _uslugePagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    updateUslugeBasedOnCart(cart);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Vaš termin",
                  style: TextStyle(
                    color: primaryMedLabOColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              sizedBoxHeightS,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Brzo dodavanje usluga",
                          style: TextStyle(
                            color: primaryMedLabOColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBoxHeightM,
                      SizedBox(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Pronađi uslugu...',
                            prefixIcon: Icon(Icons.search),
                          ),
                          controller: _uslugaSearchController,
                          onSubmitted: (value) async {
                            _uslugePagingController.refresh();
                            _fetchPageUsluge(0, searchValue: value);
                          },
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              _uslugePagingController.refresh();
                              _fetchPageUsluge(0);
                            }
                          },
                        ),
                      ),
                      sizedBoxHeightM,
                      Expanded(
                        child: PagedListView<int, Usluga>(
                          pagingController: _uslugePagingController,
                          builderDelegate: PagedChildBuilderDelegate<Usluga>(
                            itemBuilder: (context, item, index) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Text(
                                        "${item.naziv} (${item.cijena != null ? formatNumberToPrice(item.cijena) : "Nepoznato"})"),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.green[400],
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (item.uslugaID == null ||
                                            item.cijena == null ||
                                            item.naziv == null) {
                                          makeErrorToast(
                                              "Uslugu nije moguće dodati u korpu. Molimo kontaktirajte laboratorij.");
                                          return;
                                        }

                                        var tests = await _testoviProvider
                                            .getTestoviBasicDataByUslugaId(
                                                item.uslugaID!);

                                        if (tests.isEmpty) {
                                          return;
                                        }

                                        CartItem? cartItem = null;
                                        var removedTests = [];
                                        for (var i = 0; i < tests.length; i++) {
                                          cartItem =
                                              cart.getItem(tests[i].testID!);
                                          if (cartItem != null) {
                                            cart.removeItem(cartItem.id);
                                            removedTests.add(cartItem);
                                          }
                                        }

                                        String removedTestTitles = removedTests
                                            .map((cartItem) => cartItem.title)
                                            .join(", ");

                                        cart.addItem(
                                          item.uslugaID!,
                                          item.cijena ?? 0,
                                          item.naziv ?? "Nepoznato",
                                          CartItemType.usluga,
                                        );

                                        makeAlertToast(
                                            "Usluga ${item.naziv} uspješno dodana u vaš termin. ${removedTests.isNotEmpty ? "Dodavanjem ove usluge uklonili ste sljedeći/e test/ove iz korpe: $removedTestTitles" : ""}",
                                            "success",
                                            Alignment.center,
                                            cartItem != null ? 7 : 2);
                                      },
                                      child: const Icon(Icons.add_box_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sizedBoxHeightM,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Ljudi koji su odabrali usluge kao vi također su dodavali:",
                          style: TextStyle(
                            color: primaryMedLabOColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sizedBoxHeightM,
                      if (usluge == null)
                        const Center(child: CircularProgressIndicator())
                      else if (usluge!.isEmpty)
                        const Text('Nema preporučenih usluga')
                      else
                        ...usluge!.map(
                          (item) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 8,
                                      child: Text(
                                          "${item.naziv} (${item.cijena != null ? formatNumberToPrice(item.cijena) : "Nepoznato"})"),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            Colors.green[400],
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (item.uslugaID == null ||
                                              item.cijena == null ||
                                              item.naziv == null) {
                                            makeErrorToast(
                                                "Uslugu nije moguće dodati u korpu. Molimo kontaktirajte laboratorij.");
                                            return;
                                          }

                                          var tests = await _testoviProvider
                                              .getTestoviBasicDataByUslugaId(
                                                  item.uslugaID!);

                                          if (tests.isEmpty) {
                                            return;
                                          }

                                          CartItem? cartItem = null;
                                          var removedTests = [];
                                          for (var i = 0;
                                              i < tests.length;
                                              i++) {
                                            cartItem =
                                                cart.getItem(tests[i].testID!);
                                            if (cartItem != null) {
                                              cart.removeItem(cartItem.id);
                                              removedTests.add(cartItem);
                                            }
                                          }

                                          String removedTestTitles =
                                              removedTests
                                                  .map((cartItem) =>
                                                      cartItem.title)
                                                  .join(", ");

                                          cart.addItem(
                                            item.uslugaID!,
                                            item.cijena ?? 0,
                                            item.naziv ?? "Nepoznato",
                                            CartItemType.usluga,
                                          );

                                          makeAlertToast(
                                              "Usluga ${item.naziv} uspješno dodana u vaš termin. ${removedTests.isNotEmpty ? "Dodavanjem ove usluge uklonili ste sljedeći/e test/ove iz korpe: $removedTestTitles" : ""}",
                                              "success",
                                              Alignment.center,
                                              cartItem != null ? 7 : 2);
                                        },
                                        child:
                                            const Icon(Icons.add_box_outlined),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              sizedBoxHeightM,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Korpa - ${formatNumberToPrice(cart.getCartFullPrice())}",
                    style: const TextStyle(
                      color: primaryWhiteTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              sizedBoxHeightM,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const OdabirTerminaScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green[400]),
                  ),
                  child: const Center(
                    child: Text(
                      "Nastavi na odabir termina",
                      style: TextStyle(
                        color: primaryWhiteTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              sizedBoxHeightL,
            ],
          ),
        ),
      ),
    );
  }

  void updateUslugeBasedOnCart(Cart cart) async {
    var chosenUsluge = cart.getAllUslugaItems();
    if (chosenUsluge.isEmpty) {
      if (usluge != null && usluge!.isEmpty) return;
      setState(() {
        usluge = [];
      });
      return;
    }

    var data = await _uslugeProvider?.recommend(chosenUsluge.last.id);
    if (data != null && data != usluge) {
      setState(() {
        usluge = data;
      });
    }
  }
}
