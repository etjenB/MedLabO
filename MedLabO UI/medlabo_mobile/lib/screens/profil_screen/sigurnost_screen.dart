import 'package:flutter/material.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent.dart';

// ignore: must_be_immutable
class SigurnostScreen extends StatefulWidget {
  Pacijent? user;

  SigurnostScreen(this.user, {super.key});

  @override
  State<SigurnostScreen> createState() => _SigurnostScreenState();
}

class _SigurnostScreenState extends State<SigurnostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
