// To parse this JSON data, do
//
//     final razorpayOrderResponse = razorpayOrderResponseFromJson(jsonString);

import 'dart:convert';

RazorpayOrderResponse razorpayOrderResponseFromJson(String str) => RazorpayOrderResponse.fromJson(json.decode(str));

String razorpayOrderResponseToJson(RazorpayOrderResponse data) => json.encode(data.toJson());

class RazorpayOrderResponse {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  dynamic offerId;
  String? status;
  int? attempts;
  Notes? notes;
  int? createdAt;

  RazorpayOrderResponse({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  factory RazorpayOrderResponse.fromJson(Map<String, dynamic> json) => RazorpayOrderResponse(
    id: json["id"],
    entity: json["entity"],
    amount: json["amount"],
    amountPaid: json["amount_paid"],
    amountDue: json["amount_due"],
    currency: json["currency"],
    receipt: json["receipt"],
    offerId: json["offer_id"],
    status: json["status"],
    attempts: json["attempts"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "amount": amount,
    "amount_paid": amountPaid,
    "amount_due": amountDue,
    "currency": currency,
    "receipt": receipt,
    "offer_id": offerId,
    "status": status,
    "attempts": attempts,
    "notes": notes?.toJson(),
    "created_at": createdAt,
  };
}

class Notes {
  String? key1;
  String? key2;

  Notes({
    this.key1,
    this.key2,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    key1: json["key1"],
    key2: json["key2"],
  );

  Map<String, dynamic> toJson() => {
    "key1": key1,
    "key2": key2,
  };
}
