import 'package:flutter/material.dart';
import 'package:medlabo_mobile/screens/cart_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';

class CartFAB extends StatelessWidget {
  const CartFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: secondaryMedLabOColor,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => CartScreen())));
      },
      child: const Icon(
        Icons.calendar_month_outlined,
        color: Colors.white,
      ),
    );
  }
}
