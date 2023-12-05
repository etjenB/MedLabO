import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_create_request.g.dart';

@JsonSerializable()
class PaymentIntentCreateRequest {
  int? amount;

  PaymentIntentCreateRequest({
    this.amount,
  });

  factory PaymentIntentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentCreateRequestToJson(this);
}
