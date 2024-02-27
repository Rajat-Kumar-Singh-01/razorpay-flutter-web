import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_example/env.dart';
import 'package:razorpay_example/razorpay_order_response.dart';
import 'package:razorpay_web/razorpay_web.dart';

class PaymentService {

  Razorpay razorpay = Razorpay();

  void initializePayment(){
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint("Payment Successfully");
    Fluttertoast.showToast(msg: " Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
  }

  Future<dynamic> createOrder() async {

    final dio = Dio(BaseOptions(
      headers: {
        "content-type": "application/json",
        "Authorization":
        "Basic ${base64Encode(utf8.encode('${Env.razorPayKey}:${Env.razorPaySecret}'))} "
      },
      baseUrl: Url.baseUrl
    ));

    dio.interceptors.add(LogInterceptor());

    var response = await dio.post(Url.crateOrder,data: {

    "amount": 50000,
    "currency": "INR",
    "receipt": "receipt#1",
    "notes": {
    "key1": "value3",
    "key2": "value2"
    }

    });

    debugPrint("Response data : ${json.encode(response.data)}");


    if (response.statusCode == 200) {
      RazorpayOrderResponse data =
      RazorpayOrderResponse.fromJson(json.decode(json.encode(response.data)));
      openCheckout(data);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  void openCheckout(RazorpayOrderResponse data) async {
    debugPrint("Open checkout");
    var options = {
      'key': Env.razorPayKey,
      'amount': "50000",
      'name': 'Razorpay Test',
      'description': '',
      'order_id': '${data.id}',
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

}