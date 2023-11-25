import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';

class MasterScreenWidget extends StatefulWidget {
  final AuthUtil user;
  const MasterScreenWidget({required this.user, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          storage.delete(key: 'jwt_token');
          Navigator.of(context).pop();
        },
        child: const Text('Odjavi se'),
      ),
    );
  }
}
