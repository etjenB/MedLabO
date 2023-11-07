import 'package:flutter/material.dart';
import 'package:medlabo_desktop/providers/administratori_provider.dart';
import 'package:medlabo_desktop/providers/login_provider.dart';
import 'package:medlabo_desktop/providers/medicinsko_osoblje_provider.dart';
import 'package:medlabo_desktop/providers/novosti_provider.dart';
import 'package:medlabo_desktop/providers/obavijesti_provider.dart';
import 'package:medlabo_desktop/providers/test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_and_test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';
import 'package:medlabo_desktop/providers/usluge_provider.dart';
import 'package:medlabo_desktop/utils/constants/strings.dart';
import 'package:medlabo_desktop/utils/general/auth_util.dart';
import 'package:medlabo_desktop/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => TestoviProvider()),
      ChangeNotifierProvider(create: (_) => TestParametriProvider()),
      ChangeNotifierProvider(
          create: (_) => TestoviAndTestParametriProvider(
                TestoviProvider(),
                TestParametriProvider(),
              )),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => ObavijestiProvider()),
      ChangeNotifierProvider(create: (_) => UslugeProvider()),
      ChangeNotifierProvider(create: (_) => MedicinskoOsobljeProvider()),
      ChangeNotifierProvider(create: (_) => AdministratoriProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const OKToast(child: MyMaterialApp()));
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  LoginProvider? _loginProvider;
  bool loginFailed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginProvider = Provider.of<LoginProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/loginBackground.png"),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Korisničko ime',
                            prefixIcon: Icon(Icons.account_circle_outlined),
                          ),
                          controller: _usernameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Lozinka',
                            prefixIcon: const Icon(Icons.password_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          controller: _passwordController,
                        ),
                      ),
                      loginFailed == true
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Neispravni kredencijali.',
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                height: 20,
                              ),
                            ),
                      ElevatedButton(
                          onPressed: () async {
                            var username = _usernameController.text;
                            var password = _passwordController.text;
                            var isLoged =
                                await _loginProvider!.login(username, password);
                            if (isLoged) {
                              final user = await AuthUtil.create();
                              setState(() {
                                loginFailed = false;
                                _usernameController.text = "";
                                _passwordController.text = "";
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MasterScreenWidget(user: user)));
                            } else {
                              setState(() {
                                loginFailed = true;
                              });
                            }
                          },
                          child: const Text('Prijavi se')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
