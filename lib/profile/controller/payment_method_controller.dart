import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  // Mock data for payment methods
  var paymentMethods = <Map<String, dynamic>>[
    {
      "type": "card",
      "brand": "Visa",
      "last4": "4242",
      "expiry": "12/26",
      "isDefault": true,
    },
    {
      "type": "bank",
      "name": "Chase Bank",
      "last4": "1234",
      "isDefault": false,
    },
  ].obs;

  void addPaymentMethod() {
    // Logic to integrate Stripe or navigate to Add Card screen
    print("Add Payment Method clicked");
  }
}
