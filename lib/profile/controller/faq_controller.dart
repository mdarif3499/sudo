import 'package:get/get.dart';

class FaqController extends GetxController {
  // প্রতিটি আইটেমের জন্য আলাদা আলাদা স্টেট রাখার জন্য RxList ব্যবহার করছি
  var expandedIndex = (-1).obs; 

  final List<Map<String, String>> faqs = [
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
    {
      "question": "How Share Charge works?",
      "answer": "Share Charge allows users to share their charging stations with others. You can list your station, set a price, and manage bookings through the app safely and efficiently."
    },
  ];

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // যদি একই ইনডেক্সে ক্লিক করা হয় তবে বন্ধ হবে
    } else {
      expandedIndex.value = index; // নতুন ইনডেক্স ওপেন হবে
    }
  }
}
