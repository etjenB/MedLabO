import 'package:flutter/material.dart';
import 'package:medlabo_desktop/screens/administrator/novosti_i_obavijesti_screen.dart';
import 'package:medlabo_desktop/screens/administrator/testovi_screen.dart';
import 'package:medlabo_desktop/screens/administrator/uposlenici_screen.dart';
import 'package:medlabo_desktop/screens/administrator/usluge_screen.dart';
import 'package:medlabo_desktop/screens/common/izvjestaji_screen.dart';
import 'package:medlabo_desktop/screens/common/pacijenti_screen.dart';
import 'package:medlabo_desktop/screens/common/profil_screen.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/strings.dart';
import 'package:medlabo_desktop/utils/general/auth_util.dart';
import 'package:side_navigation/side_navigation.dart';

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
        const NovostiIObavijestiScreen(),
        const TestoviScreen(),
        const UslugeScreen(),
        const PacijentiScreen(),
        const UposleniciScreen(),
        const IzvjestajiScreen(),
        const ProfilScreen(),
      ];
      items = [
        const SideNavigationBarItem(
            icon: Icons.edit_notifications_outlined,
            label: 'Novosti i obavijesti'),
        const SideNavigationBarItem(
            icon: Icons.biotech_outlined, label: 'Testovi'),
        const SideNavigationBarItem(
            icon: Icons.medical_services_outlined, label: 'Usluge'),
        const SideNavigationBarItem(
            icon: Icons.people_alt_outlined, label: 'Pacijenti'),
        const SideNavigationBarItem(
            icon: Icons.work_outline, label: 'Uposlenici'),
        const SideNavigationBarItem(
            icon: Icons.document_scanner_outlined, label: 'Izvještaji'),
        const SideNavigationBarItem(
            icon: Icons.account_circle_outlined, label: 'Profil'),
      ];
    } else if (widget.user.isMedicinskoOsoblje()) {
      views = [
        const UslugeScreen(),
        const IzvjestajiScreen(),
        const ProfilScreen(),
      ];
      items = [
        const SideNavigationBarItem(
            icon: Icons.medical_services_outlined, label: 'Usluge'),
        const SideNavigationBarItem(
            icon: Icons.document_scanner_outlined, label: 'Izvještaji'),
        const SideNavigationBarItem(
            icon: Icons.account_circle_outlined, label: 'Profil'),
      ];
    } else {
      views = [
        const ProfilScreen(),
      ];
      items = [
        const SideNavigationBarItem(
            icon: Icons.account_circle_outlined, label: 'Profil')
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
                header: SideNavigationBarHeader(
                    image: Image.asset(
                      'assets/images/logo.png',
                      width: 50,
                      height: 50,
                    ),
                    title: const Text(
                      appTitle,
                      style: TextStyle(color: primaryBlackTextColor),
                    ),
                    subtitle: const Text(
                      'Sistem za medicinske laboratorije',
                      style: TextStyle(color: primaryDarkTextColor),
                    )),
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
