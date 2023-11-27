import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_mobile/models/novost/novost.dart';
import 'package:medlabo_mobile/providers/novosti_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:provider/provider.dart';

class NovostiPage extends StatefulWidget {
  const NovostiPage({super.key});

  @override
  State<NovostiPage> createState() => _NovostiPageState();
}

class _NovostiPageState extends State<NovostiPage> {
  late NovostiProvider _novostiProvider;
  static const _pageSize = 10;

  final PagingController<int, Novost> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _novostiProvider = context.read<NovostiProvider>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _novostiProvider.get(
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
                "Novosti",
                style: TextStyle(
                    color: primaryMedLabOColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: PagedListView<int, Novost>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Novost>(
                  itemBuilder: (context, item, index) => Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpandablePanel(
                            header: Text(
                              item.naslov ?? "Nema naslov",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryMedLabOColor),
                            ),
                            collapsed: Text(
                              item.sadrzaj ?? "Nema sadržaj",
                              maxLines: 5,
                              style: const TextStyle(
                                color: primaryMedLabOColor,
                                fontSize: 13,
                              ),
                            ),
                            expanded: Text(
                              item.sadrzaj ?? "Nema sadržaj",
                              style: const TextStyle(
                                color: primaryMedLabOColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
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
