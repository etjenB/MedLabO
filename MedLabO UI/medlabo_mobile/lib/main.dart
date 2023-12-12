import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medlabo_mobile/models/cart/cart.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent_registration_request.dart';
import 'package:medlabo_mobile/providers/administratori_provider.dart';
import 'package:medlabo_mobile/providers/login_provider.dart';
import 'package:medlabo_mobile/providers/novosti_provider.dart';
import 'package:medlabo_mobile/providers/pacijenti_provider.dart';
import 'package:medlabo_mobile/providers/racuni_provider.dart';
import 'package:medlabo_mobile/providers/stripe_provider.dart';
import 'package:medlabo_mobile/providers/termini_provider.dart';
import 'package:medlabo_mobile/providers/test_parametri_provider.dart';
import 'package:medlabo_mobile/providers/testovi_provider.dart';
import 'package:medlabo_mobile/providers/usluge_provider.dart';
import 'package:medlabo_mobile/providers/zakljucci_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/constants/enums.dart';
import 'package:medlabo_mobile/utils/constants/strings.dart';
import 'package:medlabo_mobile/utils/general/auth_util.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51OIGGOJG8OBixHCfR2GNnnnUj3MPNwPEnTB5fc8zsdchnW2rWUqXAiehvb9SYef1PNkaHgFqwaeCy4TuSy0e2D9t0062UKZdh2';
  initializeDateFormatting().then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProvider(create: (_) => PacijentProvider()),
          ChangeNotifierProvider(create: (_) => AdministratoriProvider()),
          ChangeNotifierProvider(create: (_) => NovostiProvider()),
          ChangeNotifierProvider(create: (_) => UslugeProvider()),
          ChangeNotifierProvider(create: (_) => TestoviProvider()),
          ChangeNotifierProvider(create: (_) => TestParametriProvider()),
          ChangeNotifierProvider(create: (_) => TerminiProvider()),
          ChangeNotifierProvider(create: (_) => RacuniProvider()),
          ChangeNotifierProvider(create: (_) => ZakljucciProvider()),
          ChangeNotifierProvider(create: (_) => StripeProvider()),
        ],
        child: const MyApp(),
      )));
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryMedLabOColor),
        useMaterial3: true,
      ),
      home: const OKToast(
        child: MyMaterialApp(),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigatorKey,
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
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginProvider = Provider.of<LoginProvider>(context);
  }

  @override
  void initState() {
    super.initState();
    checkForTokenAndRedirect();
  }

  Future<void> checkForTokenAndRedirect() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'jwt_token');
    if (token != null && !JwtDecoder.isExpired(token)) {
      final user = await AuthUtil.create();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MasterScreenWidget(user: user)));
    }
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
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _selectedTabIndex == 1
                    ? MediaQuery.of(context).size.height * 0.9
                    : MediaQuery.of(context).size.height * 0.6,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                autofocus: true,
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderTextField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: 'Ime',
                              border: InputBorder.none,
                            ),
                            name: 'ime',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Ime je obavezno."),
                              FormBuilderValidators.maxLength(50)
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(
                              labelText: 'Prezime',
                              border: InputBorder.none,
                            ),
                            name: 'prezime',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(70),
                            ],
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: "Prezime je obavezno."),
                                FormBuilderValidators.maxLength(70)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderDateTimePicker(
                            decoration: const InputDecoration(
                              labelText: 'Datum rođenja',
                              border: InputBorder.none,
                            ),
                            name: 'datumRodjenja',
                            format: DateFormat('dd-MM-yyyy'),
                            inputType: InputType.date,
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderDropdown<SpolEnum>(
                            name: 'spolID',
                            decoration: const InputDecoration(
                              labelText: 'Spol',
                              border: InputBorder.none,
                            ),
                            initialValue: SpolEnum.musko,
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: SpolEnum.values
                                .map((spol) => DropdownMenuItem(
                                      value: spol,
                                      child: Text(spol.displayName),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Adresa',
                      border: InputBorder.none,
                    ),
                    name: 'adresa',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(70),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Korisničko ime',
                      border: InputBorder.none,
                    ),
                    name: 'userName',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Korisničko ime je obavezno."),
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              border: InputBorder.none,
                            ),
                            name: 'email',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(70),
                            ],
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.email(
                                    errorText: "Unesite pravilan email."),
                                FormBuilderValidators.required(
                                    errorText: "E-mail je obavezan."),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(
                              labelText: 'Telefon',
                              border: InputBorder.none,
                            ),
                            name: 'phoneNumber',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*$')),
                            ],
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: "Telefon je obavezan."),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: 'Lozinka',
                      border: InputBorder.none,
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
                    name: 'password',
                    obscureText: _obscureText,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Lozinka je obavezna."),
                      FormBuilderValidators.minLength(8,
                          errorText:
                              "Lozinka mora imati minimalno 8 karaktera."),
                      FormBuilderValidators.maxLength(30,
                          errorText:
                              "Lozinka može imati maksimalno 30 karaktera."),
                      (val) {
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedno veliko slovo';
                        }
                        return null;
                      },
                      (val) {
                        if (!RegExp(r'(?=.*[a-z])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedno malo slovo';
                        }
                        return null;
                      },
                      (val) {
                        if (!RegExp(r'(?=.*[0-9])').hasMatch(val ?? '')) {
                          return 'Mora sadržavati najmanje jedan broj';
                        }
                        return null;
                      },
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState == null ||
                        !_formKey.currentState!.saveAndValidate()) {
                      return;
                    }

                    bool shouldProceed = await showConfirmationDialog(
                        context,
                        'Potvrda',
                        'Da li ste sigurni da su podaci koje ste unijeli tačni?');
                    if (!shouldProceed) return;

                    PacijentRegistrationRequest pacijentRegistrationRequest =
                        PacijentRegistrationRequest(
                      ime: _formKey.currentState?.value['ime'],
                      prezime: _formKey.currentState?.value['prezime'],
                      datumRodjenja:
                          _formKey.currentState?.value['datumRodjenja'],
                      adresa: _formKey.currentState?.value['adresa'],
                      spolID:
                          (_formKey.currentState?.value['spolID'] as SpolEnum)
                              .intValue,
                      userName: _formKey.currentState?.value['userName'],
                      password: _formKey.currentState?.value['password'],
                      email: _formKey.currentState?.value['email'],
                      phoneNumber: _formKey.currentState?.value['phoneNumber'],
                    );

                    var isLoged = await _loginProvider!
                        .pacijentRegistration(pacijentRegistrationRequest);

                    if (isLoged) {
                      final user = await AuthUtil.create();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              MasterScreenWidget(user: user)));
                    }
                  },
                  child: const Text(
                    'Registruj se',
                    style: TextStyle(color: primaryMedLabOColor),
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
