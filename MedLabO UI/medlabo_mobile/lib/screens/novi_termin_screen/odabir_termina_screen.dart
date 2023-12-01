import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:medlabo_mobile/models/cart/cart.dart';
import 'package:medlabo_mobile/models/stripe/payment_intent_create_request.dart';
import 'package:medlabo_mobile/models/termin/termin_insert_request.dart';
import 'package:medlabo_mobile/providers/stripe_provider.dart';
import 'package:medlabo_mobile/providers/termini_provider.dart';
import 'package:medlabo_mobile/screens/novi_termin_screen/novi_termin_screen.dart';
import 'package:medlabo_mobile/utils/constants/design.dart';
import 'package:medlabo_mobile/utils/general/dialog_utils.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';
import 'package:medlabo_mobile/utils/general/util.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OdabirTerminaScreen extends StatefulWidget {
  const OdabirTerminaScreen({super.key});

  @override
  State<OdabirTerminaScreen> createState() => _OdabirTerminaScreenState();
}

class _OdabirTerminaScreenState extends State<OdabirTerminaScreen> {
  DateTime? _selectedDay;
  String? _selectedTimeSlot;
  DateTime _focusedDay = DateTime.now().add(const Duration(days: 1));
  late TerminiProvider _terminiProvider;
  late StripeProvider _stripeProvider;
  List<String>? _availableTimeSlots = [];
  final List<String> _timeSlots = [
    "07:00",
    "07:20",
    "07:40",
    "08:00",
    "08:20",
    "08:40",
    "09:00",
    "09:20",
    "09:40",
    "10:00",
    "10:20",
    "10:40",
    "11:00",
    "11:20",
    "11:40",
    "12:00",
    "12:20",
    "12:40",
    "13:00",
    "13:20",
    "13:40",
    "14:00",
    "14:20",
    "14:40",
    "15:00"
  ];

  @override
  void initState() {
    _terminiProvider = context.read<TerminiProvider>();
    _stripeProvider = context.read<StripeProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: true);
    final _formKeyTerminInsert = GlobalKey<FormBuilderState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Odabir termina",
                    style: TextStyle(
                      color: primaryMedLabOColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                sizedBoxHeightS,
                TableCalendar(
                  firstDay: DateTime.now().add(const Duration(days: 1)),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  locale: 'bs_BA',
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: false,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  enabledDayPredicate: (day) {
                    return day.weekday != DateTime.saturday &&
                        day.weekday != DateTime.sunday;
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    var terminiOfTheDay =
                        await _terminiProvider.getTerminiOfTheDay(selectedDay);
                    var availableTimeSlots = List<String>.from(_timeSlots);
                    for (var termin in terminiOfTheDay) {
                      String terminTime =
                          DateFormat("HH:mm").format(termin.dtTermina!);
                      availableTimeSlots
                          .removeWhere((slot) => slot == terminTime);
                    }
                    setState(() {
                      _selectedDay = selectedDay;
                      _selectedTimeSlot = null;
                      _focusedDay = focusedDay;
                      _availableTimeSlots = availableTimeSlots;
                    });
                  },
                ),
                if (_selectedDay != null) ...[
                  sizedBoxHeightL,
                  Text(
                      "Dostupni termini za ${formatDateTime(_selectedDay!.toLocal().toString(), format: 'dd.MM.yyyy')}"),
                  Wrap(
                    spacing: 10,
                    children: _availableTimeSlots!
                        .map((slot) => ChoiceChip(
                              label: Text(slot),
                              selected: _selectedTimeSlot == slot,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedTimeSlot = selected ? slot : null;
                                });
                              },
                            ))
                        .toList(),
                  ),
                ],
                if (_selectedTimeSlot != null) ...[
                  sizedBoxHeightL,
                  Text(
                      "Izabrani termin: ${formatDateTime(_selectedDay!.toLocal().toString(), format: 'dd.MM.yyyy')} $_selectedTimeSlot"),
                ],
                sizedBoxHeightL,
                const Center(
                  child: Text(
                    "Korpa",
                    style: TextStyle(
                      color: primaryMedLabOColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                sizedBoxHeightM,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(cart.items.values.toList()[i].title),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            formatNumberToPrice(
                                cart.items.values.toList()[i].price),
                          ),
                          sizedBoxWidthM,
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async {
                                var item = cart.items.values.toList()[i];
                                if (await showConfirmationDialog(
                                    context,
                                    "Jeste li sigurni?",
                                    "Želite li ukloniti ${item.title} iz termina?")) {
                                  cart.removeItem(item.id);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red[400]),
                              ),
                              child: const Icon(Icons.remove_circle_outline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                sizedBoxHeightL,
                FormBuilder(
                  key: _formKeyTerminInsert,
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Napomena'),
                    name: 'napomena',
                    maxLength: 300,
                    minLines: 1,
                    maxLines: 3,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(300),
                    ],
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.maxLength(300)]),
                  ),
                ),
                sizedBoxHeightL,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[500],
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Ukupno - ${formatNumberToPrice(cart.getCartFullPrice())}",
                      style: const TextStyle(
                        color: primaryWhiteTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                sizedBoxHeightL,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKeyTerminInsert.currentState == null ||
                          !_formKeyTerminInsert.currentState!
                              .saveAndValidate()) {
                        return;
                      }

                      if (_selectedDay == null || _selectedTimeSlot == null) {
                        makeErrorToast("Morate odabrati termin.");
                        return;
                      }

                      if (cart.items.isEmpty) {
                        makeErrorToast("Korpa je prazna.");
                        return;
                      }

                      int totalAmount = (cart.getCartFullPrice() * 100).toInt();
                      await preparePaymentSheet(totalAmount);
                      await Stripe.instance.presentPaymentSheet();

                      TerminInsertRequest terminInsertRequest =
                          TerminInsertRequest(
                        dtTermina:
                            "${DateFormat('yyyy-MM-dd').format(_selectedDay!)}T${_selectedTimeSlot}:00",
                        napomena: _formKeyTerminInsert
                            .currentState?.value['napomena'],
                        usluge: cart.items.values
                            .where((item) => item.type == CartItemType.usluga)
                            .map((item) => item.id)
                            .toList(),
                        testovi: cart.items.values
                            .where((item) => item.type == CartItemType.test)
                            .map((item) => item.id)
                            .toList(),
                      );

                      await _terminiProvider.insert(terminInsertRequest);

                      makeSuccessToast("Termin uspješno zakazan.");
                      cart.clearCart();
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green[400]),
                    ),
                    child: const Center(
                      child: Text(
                        "Plati",
                        style: TextStyle(
                          color: primaryWhiteTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxHeightXL,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> preparePaymentSheet(int amount) async {
    try {
      final paymentIntentData = await _stripeProvider
          .createPaymentIntent(PaymentIntentCreateRequest(amount: amount));
      final clientSecret = paymentIntentData['clientSecret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'MedLabO',
        ),
      );
    } catch (e) {
      makeErrorToast("Greška prilikom plaćanja.");
    }
  }
}
