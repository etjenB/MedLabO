import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/cart/cart.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Vaš termin')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(cart.items.values.toList()[i].title),
                  trailing: Text(
                      formatNumberToPrice(cart.items.values.toList()[i].price)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (await showConfirmationDialog(context, "Jeste li sigurni?",
                    "Nakon ovoga sve usluge i testovi će biti uklonjeni iz termina.")) {
                  cart.clearCart();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red[400]),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Ukloni sve usluge i testove",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
