import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/screens/usluge_screen/paketi_usluga/usluga_page.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class PaketiUslugaPage extends StatefulWidget {
  const PaketiUslugaPage({super.key});

  @override
  State<PaketiUslugaPage> createState() => _PaketiUslugaPageState();
}

class _PaketiUslugaPageState extends State<PaketiUslugaPage> {
  late UslugeProvider _uslugeProvider;
  static const _pageSize = 10;

  final PagingController<int, Usluga> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _uslugeProvider = context.read<UslugeProvider>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _uslugeProvider.get(
        filter: {'Page': pageKey, 'PageSize': _pageSize},
      );
      final isLastPage = newItems.result.length < _pageSize;
      if (!mounted) return;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.result);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.result, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(children: [
            const Center(
              child: Text(
                "Usluge",
                style: TextStyle(
                    color: primaryMedLabOColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: PagedListView<int, Usluga>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Usluga>(
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UslugaPage(item),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: item.slika != null && item.slika != ""
                                    ? imageFromBase64String(item.slika!).image
                                    : const AssetImage(
                                        "assets/images/paketiUsluga.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  item.naziv!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
