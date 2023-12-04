import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_desktop/models/administrator/administrator.dart';
import 'package:medlabo_desktop/models/common/change_password_request.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje_update_request.dart';
import 'package:medlabo_desktop/providers/administratori_provider.dart';
import 'package:medlabo_desktop/providers/medicinsko_osoblje_provider.dart';
import 'package:medlabo_desktop/utils/constants/design.dart';
import 'package:medlabo_desktop/utils/constants/enums.dart';
import 'package:medlabo_desktop/utils/general/auth_util.dart';
import 'package:medlabo_desktop/utils/general/dialog_utils.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';
import 'package:provider/provider.dart';

class AdministratorProfilScreen extends StatefulWidget {
  const AdministratorProfilScreen({super.key});

  @override
  State<AdministratorProfilScreen> createState() =>
      _AdministratorProfilScreenState();
}

class _AdministratorProfilScreenState extends State<AdministratorProfilScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late AdministratoriProvider _administratoriProvider;
  Administrator? administrator;
  final _detailsFormKey = GlobalKey<FormBuilderState>();
  final _changePasswordFormKey = GlobalKey<FormBuilderState>();
  Future? _initFormFuture;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _administratoriProvider =
        Provider.of<AdministratoriProvider>(context, listen: false);
    _initFormFuture = initForm();
  }

  Future<void> initForm() async {
    final user = await AuthUtil.create();
    var data = await _administratoriProvider.getById(user.getUserId());
    if (mounted) {
      setState(() {
        administrator = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFormFuture ?? Future.value(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildProfileEdit(context);
        }
      },
    );
  }

  Widget _buildProfileEdit(BuildContext context) {
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
              offset: const Offset(0, 3),
            ),
          ],
          image: const DecorationImage(
              image: AssetImage("assets/images/loginBackground.png"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 20,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 700,
                    width: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Container(
                              height: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${administrator?.ime} ${administrator?.prezime}",
                                        style: heading1,
                                      ),
                                      const Text(
                                        "Administrator",
                                        style: heading3,
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (await showConfirmationDialog(
                                          context,
                                          "Odjava",
                                          "Jeste li sigurni da se želite odjaviti?")) {
                                        storage.delete(key: 'jwt_token');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Odjavi se'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                const TabBar(
                                  labelColor: primaryDarkTextColor,
                                  tabs: [
                                    Tab(text: 'Izmjena podataka'),
                                    Tab(text: 'Promjena lozinke'),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: TabBarView(
                                      children: [
                                        Center(
                                          child:
                                              _buildAdministratorDetailsForm(),
                                        ),
                                        _buildAdministratorChangePasswordForm(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _buildAdministratorDetailsForm() {
    return FormBuilder(
        key: _detailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(labelText: 'Ime'),
                      name: 'ime',
                      initialValue: administrator?.ime,
                      maxLength: 50,
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
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      name: 'prezime',
                      initialValue: administrator?.prezime,
                      maxLength: 70,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(70),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Prezime je obavezno."),
                        FormBuilderValidators.maxLength(70)
                      ]),
                    ),
                  ),
                ],
              ),
              FormBuilderCheckbox(
                name: 'isKontakt',
                initialValue: administrator?.isKontakt,
                title: const Text('Kontakt'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                decoration: const InputDecoration(labelText: 'Kontakt info'),
                name: 'kontaktInfo',
                initialValue: administrator?.kontaktInfo,
                maxLength: 70,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(70),
                ],
              ),
              FormBuilderTextField(
                decoration: const InputDecoration(labelText: 'Korisničko ime'),
                name: 'userName',
                initialValue: administrator?.userName,
                maxLength: 30,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Korisničko ime je obavezno."),
                ]),
              ),
              FormBuilderTextField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                name: 'email',
                initialValue: administrator?.email,
                maxLength: 60,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(
                      errorText: "Unesite ispravan email."),
                  FormBuilderValidators.required(
                      errorText: "E-mail je obavezan."),
                ]),
              ),
              FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Telefon'),
                  name: 'phoneNumber',
                  initialValue: administrator?.phoneNumber,
                  maxLength: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Telefon je obavezan."),
                  ])),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    if (_detailsFormKey.currentState == null ||
                        !_detailsFormKey.currentState!.saveAndValidate()) {
                      return;
                    }

                    bool shouldProceed = await showConfirmationDialog(
                        context,
                        'Potvrda',
                        'Da li ste sigurni da želite izmjeniti podatke?');
                    if (!shouldProceed) return;

                    Administrator administratorUpdateRequest = Administrator(
                      id: administrator!.id,
                      ime: _detailsFormKey.currentState?.value['ime'],
                      prezime: _detailsFormKey.currentState?.value['prezime'],
                      isKontakt: _detailsFormKey
                              .currentState?.value['isKontakt'] as bool? ??
                          false,
                      kontaktInfo:
                          _detailsFormKey.currentState?.value['kontaktInfo'],
                      userName: _detailsFormKey.currentState?.value['userName'],
                      email: _detailsFormKey.currentState?.value['email'],
                      phoneNumber:
                          _detailsFormKey.currentState?.value['phoneNumber'],
                    );

                    await _administratoriProvider.update(
                        administrator!.id!, administratorUpdateRequest);

                    makeSuccessToast("Uspješno izmjenjeni podaci.");
                  },
                  child: const Text(
                    'Spasi izmjene',
                    style: TextStyle(color: primaryWhiteTextColor),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  FormBuilder _buildAdministratorChangePasswordForm() {
    return FormBuilder(
        key: _changePasswordFormKey,
        child: SingleChildScrollView(
          child: Column(children: [
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: 'Nova lozinka',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              name: 'newPassword',
              maxLength: 30,
              obscureText: _isPasswordObscured,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Lozinka je obavezna."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Lozinka može imati maksimalno 30 karaktera."),
              ]),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: 'Potvrda nove lozinke',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                    });
                  },
                ),
              ),
              name: 'confirmNewPassword',
              maxLength: 30,
              obscureText: _isConfirmPasswordObscured,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Lozinka je obavezna."),
                FormBuilderValidators.minLength(8,
                    errorText: "Lozinka mora imati minimalno 8 karaktera."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Lozinka može imati maksimalno 30 karaktera."),
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
                (val) {
                  if (val !=
                      _changePasswordFormKey
                          .currentState?.fields['newPassword']?.value) {
                    return 'Lozinke se ne podudaraju';
                  }
                  return null;
                },
              ]),
              onChanged: (val) {
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                onPressed: _passwordsMatch()
                    ? () async {
                        if (_changePasswordFormKey.currentState == null ||
                            !_changePasswordFormKey.currentState!
                                .saveAndValidate()) {
                          return;
                        }

                        bool shouldProceed = await showConfirmationDialog(
                            context,
                            'Potvrda',
                            'Da li ste sigurni da želite promjeniti lozinku?');
                        if (!shouldProceed) return;

                        ChangePasswordRequest changePasswordRequest =
                            ChangePasswordRequest(
                                userId: administrator!.id,
                                newPassword: _changePasswordFormKey
                                    .currentState?.value['newPassword'],
                                confirmNewPassword: _changePasswordFormKey
                                    .currentState?.value['confirmNewPassword']);

                        await _administratoriProvider
                            .changePassword(changePasswordRequest);

                        makeSuccessToast("Uspješno promjenjena lozinka.");
                      }
                    : null,
                child: const Text(
                  'Promjeni lozinku',
                  style: TextStyle(color: primaryWhiteTextColor),
                ),
              ),
            ),
          ]),
        ));
  }

  bool _passwordsMatch() {
    _changePasswordFormKey.currentState?.validate();
    final newPassword =
        _changePasswordFormKey.currentState?.fields['newPassword']?.value;
    final confirmPassword = _changePasswordFormKey
        .currentState?.fields['confirmNewPassword']?.value;
    return newPassword == confirmPassword;
  }
}

class MedicinskoOsobljeProfilScreen extends StatefulWidget {
  const MedicinskoOsobljeProfilScreen({super.key});

  @override
  State<MedicinskoOsobljeProfilScreen> createState() =>
      _MedicinskoOsobljeProfilScreenState();
}

class _MedicinskoOsobljeProfilScreenState
    extends State<MedicinskoOsobljeProfilScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late MedicinskoOsobljeProvider _medicinskoOsobljeProvider;
  MedicinskoOsoblje? medOso;
  final _detailsFormKey = GlobalKey<FormBuilderState>();
  final _changePasswordFormKey = GlobalKey<FormBuilderState>();
  Future? _initFormFuture;
  bool _isPasswordObscured = true;
  bool _isOldPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _medicinskoOsobljeProvider =
        Provider.of<MedicinskoOsobljeProvider>(context, listen: false);
    _initFormFuture = initForm();
  }

  Future<void> initForm() async {
    final user = await AuthUtil.create();
    var data = await _medicinskoOsobljeProvider
        .getByIdWithProperties(user.getUserId());
    if (mounted) {
      setState(() {
        medOso = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFormFuture ?? Future.value(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildProfileEdit(context);
        }
      },
    );
  }

  Widget _buildProfileEdit(BuildContext context) {
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
              offset: const Offset(0, 3),
            ),
          ],
          image: const DecorationImage(
              image: AssetImage("assets/images/loginBackground.png"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 20,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 710,
                    width: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Container(
                              height: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${medOso?.ime} ${medOso?.prezime}",
                                        style: heading1,
                                      ),
                                      Text(
                                        medOso!.zvanje!.naziv!,
                                        style: heading3,
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (await showConfirmationDialog(
                                          context,
                                          "Odjava",
                                          "Jeste li sigurni da se želite odjaviti?")) {
                                        storage.delete(key: 'jwt_token');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Odjavi se'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                const TabBar(
                                  labelColor: primaryDarkTextColor,
                                  tabs: [
                                    Tab(text: 'Izmjena podataka'),
                                    Tab(text: 'Promjena lozinke'),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: TabBarView(
                                      children: [
                                        Center(
                                          child:
                                              _buildMedicinskoOsobljeDetailsForm(),
                                        ),
                                        _buildMedicinskoOsobljeChangePasswordForm(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildMedicinskoOsobljeDetailsForm() {
    return FormBuilder(
      key: _detailsFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Ime'),
                    name: 'ime',
                    initialValue: medOso?.ime,
                    maxLength: 50,
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
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Prezime'),
                    name: 'prezime',
                    initialValue: medOso?.prezime,
                    maxLength: 70,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(70),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Prezime je obavezno."),
                      FormBuilderValidators.maxLength(70)
                    ]),
                  ),
                ),
              ),
            ],
          ),
          FormBuilderCheckbox(
            name: 'isActive',
            initialValue: medOso?.isActive,
            title: const Text('Aktivan'),
            validator: FormBuilderValidators.required(),
          ),
          FormBuilderDropdown<SpolEnum>(
            name: 'spolID',
            decoration: const InputDecoration(labelText: 'Spol'),
            initialValue: SpolExtension.fromInt(medOso!.spol!.spolID!),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            items: SpolEnum.values
                .map((spol) => DropdownMenuItem(
                      value: spol,
                      child: Text(spol.displayName),
                    ))
                .toList(),
          ),
          FormBuilderDropdown<ZvanjeEnum>(
            name: 'zvanjeID',
            decoration: const InputDecoration(labelText: 'Zvanje'),
            initialValue: ZvanjeExtension.fromInt(medOso!.zvanje!.zvanjeID!),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            items: ZvanjeEnum.values
                .map((zvanje) => DropdownMenuItem(
                      value: zvanje,
                      child: Text(zvanje.displayName),
                    ))
                .toList(),
          ),
          FormBuilderTextField(
            decoration: const InputDecoration(labelText: 'Korisničko ime'),
            name: 'userName',
            initialValue: medOso?.userName,
            maxLength: 30,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Korisničko ime je obavezno."),
            ]),
          ),
          FormBuilderTextField(
            decoration: const InputDecoration(labelText: 'E-mail'),
            name: 'email',
            initialValue: medOso?.email,
            maxLength: 60,
            inputFormatters: [
              LengthLimitingTextInputFormatter(60),
            ],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(errorText: "Unesite ispravan email."),
              FormBuilderValidators.required(errorText: "E-mail je obavezan."),
            ]),
          ),
          FormBuilderTextField(
              decoration: const InputDecoration(labelText: 'Telefon'),
              name: 'phoneNumber',
              initialValue: medOso?.phoneNumber,
              maxLength: 10,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Telefon je obavezan."),
              ])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () async {
                if (_detailsFormKey.currentState == null ||
                    !_detailsFormKey.currentState!.saveAndValidate()) {
                  return;
                }

                bool shouldProceed = await showConfirmationDialog(
                    context,
                    'Potvrda',
                    'Da li ste sigurni da želite izmjeniti podatke uposlenika?');
                if (!shouldProceed) return;

                MedicinskoOsobljeUpdateRequest medicinskoOsobljeUpdateRequest =
                    MedicinskoOsobljeUpdateRequest(
                  id: medOso!.id,
                  ime: _detailsFormKey.currentState?.value['ime'],
                  prezime: _detailsFormKey.currentState?.value['prezime'],
                  isActive: _detailsFormKey.currentState?.value['isActive']
                          as bool? ??
                      false,
                  spolID: (_detailsFormKey.currentState?.value['spolID']
                          as SpolEnum)
                      .intValue,
                  zvanjeID: (_detailsFormKey.currentState?.value['zvanjeID']
                          as ZvanjeEnum)
                      .intValue,
                  userName: _detailsFormKey.currentState?.value['userName'],
                  email: _detailsFormKey.currentState?.value['email'],
                  phoneNumber:
                      _detailsFormKey.currentState?.value['phoneNumber'],
                );

                await _medicinskoOsobljeProvider.update(
                    medOso!.id!, medicinskoOsobljeUpdateRequest);

                makeSuccessToast("Uspješno izmjenjeni podaci.");
              },
              child: const Text(
                'Spasi izmjene',
                style: TextStyle(color: primaryWhiteTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FormBuilder _buildMedicinskoOsobljeChangePasswordForm() {
    return FormBuilder(
        key: _changePasswordFormKey,
        child: SingleChildScrollView(
          child: Column(children: [
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: 'Stara lozinka',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isOldPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isOldPasswordObscured = !_isOldPasswordObscured;
                    });
                  },
                ),
              ),
              name: 'oldPassword',
              maxLength: 30,
              obscureText: _isOldPasswordObscured,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Lozinka je obavezna."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Lozinka može imati maksimalno 30 karaktera."),
              ]),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: 'Nova lozinka',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              name: 'newPassword',
              maxLength: 30,
              obscureText: _isPasswordObscured,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Lozinka je obavezna."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Lozinka može imati maksimalno 30 karaktera."),
              ]),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                labelText: 'Potvrda nove lozinke',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                    });
                  },
                ),
              ),
              name: 'confirmNewPassword',
              maxLength: 30,
              obscureText: _isConfirmPasswordObscured,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Lozinka je obavezna."),
                FormBuilderValidators.minLength(8,
                    errorText: "Lozinka mora imati minimalno 8 karaktera."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Lozinka može imati maksimalno 30 karaktera."),
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
                (val) {
                  if (val !=
                      _changePasswordFormKey
                          .currentState?.fields['newPassword']?.value) {
                    return 'Lozinke se ne podudaraju';
                  }
                  return null;
                },
              ]),
              onChanged: (val) {
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                onPressed: _passwordsMatch()
                    ? () async {
                        if (_changePasswordFormKey.currentState == null ||
                            !_changePasswordFormKey.currentState!
                                .saveAndValidate()) {
                          return;
                        }

                        bool shouldProceed = await showConfirmationDialog(
                            context,
                            'Potvrda',
                            'Da li ste sigurni da želite promjeniti lozinku?');
                        if (!shouldProceed) return;

                        ChangePasswordRequest changePasswordRequest =
                            ChangePasswordRequest(
                                userId: medOso!.id,
                                oldPassword: _changePasswordFormKey
                                    .currentState?.value['oldPassword'],
                                newPassword: _changePasswordFormKey
                                    .currentState?.value['newPassword'],
                                confirmNewPassword: _changePasswordFormKey
                                    .currentState?.value['confirmNewPassword']);

                        await _medicinskoOsobljeProvider
                            .changePassword(changePasswordRequest);

                        makeSuccessToast("Uspješno promjenjena lozinka.");
                      }
                    : null,
                child: const Text(
                  'Promjeni lozinku',
                  style: TextStyle(color: primaryWhiteTextColor),
                ),
              ),
            ),
          ]),
        ));
  }

  bool _passwordsMatch() {
    _changePasswordFormKey.currentState?.validate();
    final newPassword =
        _changePasswordFormKey.currentState?.fields['newPassword']?.value;
    final confirmPassword = _changePasswordFormKey
        .currentState?.fields['confirmNewPassword']?.value;
    return newPassword == confirmPassword;
  }
}
