import 'package:flutter/material.dart';
import 'package:medlabo_mobile/providers/login_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/constants/strings.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';
import 'package:medlabo_mobile/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
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
  int _selectedTabIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginProvider = Provider.of<LoginProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: primaryMedLabOColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _selectedTabIndex == 1
                    ? MediaQuery.of(context).size.height * 0.9
                    : MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "MedLab",
                              style: TextStyle(
                                  color: primaryMedLabOColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/images/logo.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Colors.white,
                              indicatorColor: Colors.white,
                              tabs: const [
                                Tab(text: 'Prijavi se'),
                                Tab(text: 'Registruj se'),
                              ],
                              onTap: (index) {
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Center(
                                      child: _buildLoginForm(),
                                    ),
                                    _buildRegistrationForm(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Korisničko ime',
                prefixIcon: Icon(Icons.account_circle_outlined),
              ),
              controller: _usernameController,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              autocorrect: false,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Lozinka',
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;
                var isLoged = await _loginProvider!.login(username, password);
                if (isLoged) {
                  final user = await AuthUtil.create();
                  setState(() {
                    loginFailed = false;
                    _usernameController.text = "";
                    _passwordController.text = "";
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MasterScreenWidget(user: user)));
                } else {
                  setState(() {
                    loginFailed = true;
                  });
                }
              },
              child: const Text(
                'Prijavi se',
                style: TextStyle(color: primaryMedLabOColor),
              )),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Container(
      child: const Text("Registruj se danas"),
    );
  }
}
