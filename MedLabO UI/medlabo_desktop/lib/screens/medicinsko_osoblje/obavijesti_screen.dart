import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medlabo_desktop/models/obavijest/obavijest.dart';
import 'package:medlabo_desktop/providers/obavijesti_provider.dart';
import 'package:medlabo_desktop/utils/general/util.dart';
import 'package:provider/provider.dart';

class ObavijestiScreen extends StatefulWidget {
  const ObavijestiScreen({super.key});

  @override
  _ObavijestiScreenState createState() => _ObavijestiScreenState();
}

class _ObavijestiScreenState extends State<ObavijestiScreen> {
  late ObavijestiProvider _obavijestiProvider;
  static const _pageSize = 10;

  final PagingController<int, Obavijest> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _obavijestiProvider = context.read<ObavijestiProvider>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _obavijestiProvider.get(
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
          child: PagedListView<int, Obavijest>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Obavijest>(
              itemBuilder: (context, item, index) => Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: ClipRect(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: item.slika == null || item.slika == ""
                                ? const Center(
                                    child: Text("Nema slike"),
                                  )
                                : imageFromBase64String(item.slika!),
                          ),
                        ),
                      ),
                      Text(
                        item.naslov ?? 'Naslov nije dostupan',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.sadrzaj ?? 'Sadržaj nije dostupan',
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => _showObavijestModal(context, item),
                          child: const Text('Pročitaj'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showObavijestModal(BuildContext context, Obavijest obavijest) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(obavijest.naslov ?? 'Naslov nije dostupan'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(obavijest.sadrzaj ?? 'Sadržaj nije dostupan'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Zatvori'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
