import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';
import 'package:medlabo_mobile/providers/termini_provider.dart';
import 'package:medlabo_mobile/screens/termini_screen/arhiva_rezultata_screen.dart';
import 'package:medlabo_mobile/screens/termini_screen/nadolazeci_termin_screen.dart';
import 'package:medlabo_mobile/screens/termini_screen/prethodni_termin_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({super.key});

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  late TerminiProvider _terminiProvider;
  static const _pageSize = 6;
  final PagingController<int, Termin> _terminiInFuturePagingController =
      PagingController(firstPageKey: 0);
  final PagingController<int, Termin> _terminiBeforePagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _terminiProvider = context.read<TerminiProvider>();
    _terminiInFuturePagingController.addPageRequestListener((pageKey) {
      _fetchPageTerminiInFuture(pageKey);
    });
    _terminiBeforePagingController.addPageRequestListener((pageKey) {
      _fetchPageTerminiBefore(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPageTerminiInFuture(int pageKey) async {
    var user = await AuthUtil.create();
    try {
      final newItems = await _terminiProvider.get(
        filter: {
          'Page': pageKey,
          'PageSize': _pageSize,
          'PacijentId': user.getUserId(),
          'TerminiInFuture': true,
          'Odobren': true,
          'OrderByDTTermina': true,
        },
      );
      final isLastPage = newItems.result.length < _pageSize;
      if (!mounted) return;
      if (isLastPage) {
        _terminiInFuturePagingController.appendLastPage(newItems.result);
      } else {
        final nextPageKey = pageKey + 1;
        _terminiInFuturePagingController.appendPage(
            newItems.result, nextPageKey);
      }
    } catch (error) {
      _terminiInFuturePagingController.error = error;
    }
  }

  Future<void> _fetchPageTerminiBefore(int pageKey) async {
    var user = await AuthUtil.create();
    try {
      final newItems = await _terminiProvider.get(
        filter: {
          'Page': pageKey,
          'PageSize': _pageSize,
          'PacijentId': user.getUserId(),
          'Finaliziran': true,
          'Odobren': true,
          'OrderByDTTermina': true,
        },
      );
      final isLastPage = newItems.result.length < _pageSize;
      if (!mounted) return;
      if (isLastPage) {
        _terminiBeforePagingController.appendLastPage(newItems.result);
      } else {
        final nextPageKey = pageKey + 1;
        _terminiBeforePagingController.appendPage(newItems.result, nextPageKey);
      }
    } catch (error) {
      _terminiBeforePagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: Column(
          children: [
            const Center(
              child: Text(
                "Termini",
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
                        "Lista nadolazećih termina",
                        style: TextStyle(
                          color: primaryMedLabOColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    sizedBoxHeightM,
                    Expanded(
                      child: PagedListView<int, Termin>(
                        pagingController: _terminiInFuturePagingController,
                        builderDelegate: PagedChildBuilderDelegate<Termin>(
                          itemBuilder: (context, item, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NadolazeciTerminScreen(item)));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Termin ${item.dtTermina != null ? formatDateTime(item.dtTermina!) : 'Nepoznato'}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
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
                        "Lista prethodnih termina",
                        style: TextStyle(
                          color: primaryMedLabOColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    sizedBoxHeightM,
                    Expanded(
                      child: PagedListView<int, Termin>(
                        pagingController: _terminiBeforePagingController,
                        builderDelegate: PagedChildBuilderDelegate<Termin>(
                          itemBuilder: (context, item, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PrethodniTerminScreen(item)));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Termin ${item.dtTermina != null ? formatDateTime(item.dtTermina!) : 'Nepoznato'}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
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
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ArhivaRezultataScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  side: MaterialStateProperty.all(
                    const BorderSide(color: primaryMedLabOColor, width: 2.0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Arhiva rezulata",
                    style: TextStyle(
                      color: primaryMedLabOColor,
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
