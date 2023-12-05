import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent_update_request.dart';
import 'package:medlabo_mobile/providers/pacijenti_provider.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/constants/enums.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UredjivanjeProfilaScreen extends StatefulWidget {
  Pacijent? user;
  final Function(Pacijent) updateUser;

  UredjivanjeProfilaScreen(this.user, {required this.updateUser, super.key});

  @override
  State<UredjivanjeProfilaScreen> createState() =>
      _UredjivanjeProfilaScreenState();
}

class _UredjivanjeProfilaScreenState extends State<UredjivanjeProfilaScreen> {
  final _detailsFormKey = GlobalKey<FormBuilderState>();
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
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration:
                          const BoxDecoration(color: primaryMedLabOColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                    _buildMedicinskoOsobljeDetailsForm(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMedicinskoOsobljeDetailsForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FormBuilder(
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
                      initialValue: widget.user?.ime,
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
                      initialValue: widget.user?.prezime,
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
            FormBuilderDateTimePicker(
              decoration: const InputDecoration(
                labelText: 'Datum rođenja',
              ),
              name: 'datumRodjenja',
              initialDate: widget.user!.datumRodjenja,
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              initialValue: widget.user!.datumRodjenja,
              firstDate: DateTime(1920),
              lastDate: DateTime.now(),
            ),
            FormBuilderTextField(
              decoration: const InputDecoration(
                labelText: 'Adresa',
              ),
              name: 'adresa',
              inputFormatters: [
                LengthLimitingTextInputFormatter(70),
              ],
            ),
            FormBuilderDropdown<SpolEnum>(
              name: 'spolID',
              decoration: const InputDecoration(labelText: 'Spol'),
              initialValue: SpolExtension.fromInt(widget.user!.spolID!),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
              items: SpolEnum.values
                  .map((spol) => DropdownMenuItem(
                        value: spol,
                        child: Text(spol.displayName),
                      ))
                  .toList(),
            ),
            FormBuilderTextField(
              decoration: const InputDecoration(labelText: 'Korisničko ime'),
              name: 'userName',
              initialValue: widget.user?.userName,
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
              initialValue: widget.user?.email,
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
                initialValue: widget.user?.phoneNumber,
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
                      'Da li ste sigurni da želite izmjeniti podatke profila?');
                  if (!shouldProceed) return;

                  PacijentUpdateRequest pacijentUpdateRequest =
                      PacijentUpdateRequest(
                    id: widget.user!.id,
                    ime: _detailsFormKey.currentState?.value['ime'],
                    prezime: _detailsFormKey.currentState?.value['prezime'],
                    datumRodjenja:
                        _detailsFormKey.currentState?.value['datumRodjenja'],
                    adresa: _detailsFormKey.currentState?.value['adresa'],
                    spolID: (_detailsFormKey.currentState?.value['spolID']
                            as SpolEnum)
                        .intValue,
                    userName: _detailsFormKey.currentState?.value['userName'],
                    email: _detailsFormKey.currentState?.value['email'],
                    phoneNumber:
                        _detailsFormKey.currentState?.value['phoneNumber'],
                  );

                  await _pacijentProvider.update(
                      widget.user!.id!, pacijentUpdateRequest);

                  makeSuccessToast("Uspješno izmijenjeni podaci.");

                  var updatedUser =
                      await _pacijentProvider.getById(widget.user!.id!);
                  setState(() {
                    widget.user = updatedUser;
                  });

                  widget.updateUser(updatedUser);
                },
                child: const Text(
                  'Spasi izmjene',
                  style: TextStyle(color: primaryWhiteTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
