import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medlabo_mobile/screens/home_screen/home_screen.dart';
import 'package:medlabo_mobile/screens/novi_termin_screen.dart';
import 'package:medlabo_mobile/screens/profil_screen.dart';
import 'package:medlabo_mobile/screens/termini_screen.dart';
import 'package:medlabo_mobile/screens/usluge_screen/usluge_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MasterScreenWidget extends StatefulWidget {
  final AuthUtil user;
  const MasterScreenWidget({required this.user, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const UslugeScreen(),
      const NoviTerminScreen(),
      const TerminiScreen(),
      const ProfilScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Početna"),
        activeColorPrimary: secondaryMedLabOColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.medical_services_outlined),
        title: ("Usluge"),
        activeColorPrimary: secondaryMedLabOColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add_outlined),
        iconSize: 40,
        title: ("Zakaži termin"),
        activeColorPrimary: secondaryMedLabOColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.calendar_today_outlined),
        title: ("Termini"),
        activeColorPrimary: secondaryMedLabOColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        title: ("Profil"),
        activeColorPrimary: secondaryMedLabOColor,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarHeight: MediaQuery.of(context).size.height * 0.08,
        confineInSafeArea: true,
        backgroundColor: primaryMedLabOColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: primaryMedLabOColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style16,
      ),
    );
  }
}
