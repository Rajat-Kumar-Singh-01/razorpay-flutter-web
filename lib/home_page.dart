import 'package:flutter/material.dart';
import 'package:razorpay_example/payment_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final paymentService = PaymentService();

  @override
  void initState() {
    super.initState();
    paymentService.initializePayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: ElevatedButton(child: const Text("Open Razorpay"),onPressed: (){
          paymentService.createOrder();
        }),
      )
    );
  }
}
