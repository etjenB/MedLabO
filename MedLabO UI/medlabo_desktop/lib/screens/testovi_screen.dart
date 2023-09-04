import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/testovi_provider.dart';

class TestoviScreen extends StatefulWidget {
  const TestoviScreen({super.key});

  @override
  State<TestoviScreen> createState() => _TestoviScreenState();
}

class _TestoviScreenState extends State<TestoviScreen> {
  late TestoviProvider _testoviProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _testoviProvider = context.read<TestoviProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text('TESTOVI'),
            ElevatedButton(
                onPressed: () async {
                  //Navigator.of(context).pop();
                  var data = await _testoviProvider.get();
                  print('data: $data');
                },
                child: Text('GET TESTOVE')),
          ],
        ),
      ),
    );
  }
}
