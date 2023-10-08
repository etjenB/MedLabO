import 'package:flutter/material.dart';
import 'package:medlabo_desktop/screens/profil_screen.dart';
import 'package:medlabo_desktop/utils/general/auth_util.dart';
import '../screens/usluge_screen.dart';
import 'package:side_navigation/side_navigation.dart';
import '../screens/testovi_screen.dart';

// ignore: must_be_immutable
class MasterScreenWidget extends StatefulWidget {
  final AuthUtil user;
  const MasterScreenWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> views;
    List<SideNavigationBarItem> items;

    if (widget.user.isAdministrator()) {
      views = [
        const TestoviScreen(),
        const UslugeScreen(),
        const ProfilScreen(),
      ];
      items = [
        const SideNavigationBarItem(
            icon: Icons.biotech_outlined, label: 'Testovi'),
        const SideNavigationBarItem(
            icon: Icons.medical_services_outlined, label: 'Usluge'),
        const SideNavigationBarItem(
            icon: Icons.co_present_outlined, label: 'Profil'),
      ];
    } else if (widget.user.isMedicinskoOsoblje()) {
      views = [const UslugeScreen(), const ProfilScreen()];
      items = [
        const SideNavigationBarItem(
            icon: Icons.medical_services_outlined, label: 'Usluge'),
        const SideNavigationBarItem(
            icon: Icons.co_present_outlined, label: 'Profil'),
      ];
    } else {
      views = [const ProfilScreen()];
      items = [
        const SideNavigationBarItem(
            icon: Icons.co_present_outlined, label: 'Profil')
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SideNavigationBar(
                selectedIndex: selectedIndex,
                items: items,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
            Expanded(
              child: views.elementAt(selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
