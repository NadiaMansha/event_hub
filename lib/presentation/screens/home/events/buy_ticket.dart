import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({super.key});

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  CardFormEditController controller = CardFormEditController();
  var paymentIntent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Payment', style: TextStyle(color: Colors.black))),
        body: Column(children: [
          const SizedBox(height: 40),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardFormField(
                controller: controller,
              )),
          ElevatedButton(
            onPressed: _handlePayPress,
            child: Text('Pay'),
          )
        ]));
  }

  void _handlePayPress() {
    print(controller.details.cvc);
  }
}
