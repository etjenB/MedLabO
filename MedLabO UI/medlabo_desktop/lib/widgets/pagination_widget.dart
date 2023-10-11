import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationWidget({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed:
              currentPage == 1 ? null : () => onPageChanged(currentPage - 1),
          child: const Text('Prethodna'),
        ),
        const SizedBox(width: 20),
        Text('Stranica $currentPage/$totalPages'),
        const SizedBox(width: 20),
        SizedBox(
          width: 70,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Otiđi na',
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            onSubmitted: (value) {
              int? page = int.tryParse(value);
              if (page != null && page > 0 && page <= totalPages) {
                onPageChanged(page);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Neispravan broj stranice')),
                );
              }
            },
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: currentPage >= totalPages
              ? null
              : () => onPageChanged(currentPage + 1),
          child: const Text('Sljedeća'),
        ),
      ],
    );
  }
}
