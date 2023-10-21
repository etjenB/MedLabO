import 'package:flutter/material.dart';
import 'package:medlabo_desktop/models/search_result.dart';

mixin PaginationMixin<T> {
  int currentPage = 1;
  late int itemsPerPage = 10;
  final pageController = TextEditingController();
  int totalItems = 0;
  int get totalPages => (totalItems / itemsPerPage).ceil();
  String currentSearchTerm = '';

  Future<SearchResult<T>> fetchData(
      int page,
      Future<SearchResult<T>> Function(Map<String, dynamic> filter)
          fetchFunction,
      [String? searchTermAttribute,
      Map<String, dynamic>? additionalFilters]) async {
    var defaultFilter = {
      if (currentSearchTerm.isNotEmpty && searchTermAttribute != null)
        searchTermAttribute: currentSearchTerm,
      'Page': page - 1,
      'PageSize': itemsPerPage,
    };

    var filter = {...defaultFilter, ...?additionalFilters};

    var result = await fetchFunction(filter);

    if (result.count == 0 && page > 1) {
      currentPage--;
      return await fetchData(currentPage, fetchFunction);
    }

    totalItems = result.count;
    currentPage = page;
    return result;
  }
}
