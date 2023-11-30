import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_mobile/models/cart/cart.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
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
  late UslugeProvider _uslugeProvider;
  static const _pageSize = 6;
  final TextEditingController _uslugaSearchController =
      new TextEditingController();
  final PagingController<int, Usluga> _uslugePagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _uslugeProvider = context.read<UslugeProvider>();
    _uslugePagingController.addPageRequestListener((pageKey) {
      _fetchPageUsluge(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPageUsluge(int pageKey, {String? searchValue = ""}) async {
    try {
      final newItems = await _uslugeProvider.get(
        filter: {'Page': pageKey, 'PageSize': _pageSize, 'Naziv': searchValue},
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
    var cart = Provider.of<Cart>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
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
            sizedBoxHeightL,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      backgroundColor: MaterialStatePropertyAll(
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

                                      cart.addItem(item.uslugaID!, item.cijena!,
                                          item.naziv!, CartItemType.usluga);

                                      makeSuccessToast(
                                          "Uspješno dodana usluga ${item.naziv}.");
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
                  backgroundColor: MaterialStatePropertyAll(Colors.green[400]),
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
          ],
        ),
      ),
    );
  }
}
