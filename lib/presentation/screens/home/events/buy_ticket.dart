import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({super.key});

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  CardFieldInputDetails? _card;
  var paymentIntent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const SizedBox(height: 40),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CardField(
          onCardChanged: (card) {
            setState(() {
              _card = card;
              print(_card);
            });
          },
        ),
      ),
    ]));
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }
}
