import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:medlabo_mobile/models/common/change_password_request.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent.dart';
import 'package:medlabo_mobile/providers/pacijenti_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SigurnostScreen extends StatefulWidget {
  Pacijent? user;

  SigurnostScreen(this.user, {super.key});

  @override
  State<SigurnostScreen> createState() => _SigurnostScreenState();
}

class _SigurnostScreenState extends State<SigurnostScreen> {
  final _changePasswordFormKey = GlobalKey<FormBuilderState>();
  bool _isPasswordObscured = true;
  bool _isOldPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  late PacijentProvider _pacijentProvider;

  @override
  void initState() {
    super.initState();
    _pacijentProvider = context.read<PacijentProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: widget.user == null
            ? const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration:
                          const BoxDecoration(color: primaryMedLabOColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "${widget.user!.ime} ${widget.user!.prezime}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                              Center(
                                  child: Text(
                                "${widget.user!.email}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildPacijentChangePasswordForm(),
                  ],
                ),
              ),
      ),
    );
  }

  FormBuilder _buildPacijentChangePasswordForm() {
    return FormBuilder(
      key: _changePasswordFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
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
                        _isConfirmPasswordObscured =
                            !_isConfirmPasswordObscured;
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
                                  userId: widget.user!.id,
                                  oldPassword: _changePasswordFormKey
                                      .currentState?.value['oldPassword'],
                                  newPassword: _changePasswordFormKey
                                      .currentState?.value['newPassword'],
                                  confirmNewPassword: _changePasswordFormKey
                                      .currentState
                                      ?.value['confirmNewPassword']);

                          await _pacijentProvider
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
            ],
          ),
        ),
      ),
    );
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
