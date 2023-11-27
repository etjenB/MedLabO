import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/novost/novost.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';

class NovostPage extends StatefulWidget {
  Novost novost;

  NovostPage(this.novost, {super.key});

  @override
  State<NovostPage> createState() => _NovostPageState();
}

class _NovostPageState extends State<NovostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.novost.naslov ?? "Nema naslov",
                style: heading1,
              ),
              sizedBoxHeightM,
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.novost.sadrzaj ?? "Nema sadržaj",
                    style: articleTextSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
