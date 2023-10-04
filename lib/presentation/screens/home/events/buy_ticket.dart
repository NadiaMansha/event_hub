import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/widgets/button.dart';
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
              padding: const EdgeInsets.all(10.0),
              child: CardFormField(
                style: CardFormStyle(
                  placeholderColor: Colors.black,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 18,
                  cursorColor: Colors.black,
                  borderColor: Colors.grey,
                  borderWidth: 1,
                  borderRadius: 10,
                ),
                controller: controller,
              )),
          Button(
              title: 'Pay',
              onPressed: () {
                _handlePayPress();
              },
              backgroundColor: AppColors().primary,
              foregroundColor: Colors.white,
              isLoading: false)
        ]));
  }

  void _handlePayPress() {
    print(controller.details.cvc);
  }
}
