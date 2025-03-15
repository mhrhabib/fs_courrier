import 'package:fs_currier/Screen/Parcel/parcel_index.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../repository/payment_repository.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;

  makePayment({
    String? phone,
    String? amount,
    String? paymentId,
    String? paymentMethod,
    String? paymentType,
    String? url,
  }) async {
    isLoading.value = true; // Show loader
    try {
      // Simulate API call or payment processing
      var response = await PaymentRepository.makePayment(
        phone: phone,
        amount: amount,
        paymentId: paymentId,
        paymentMethod: paymentMethod,
        paymentType: paymentType,
        url: url,
      );
      print('<><><><><><><><><><response><><><><><><> $response');

      // Wait for 10 seconds (simulating payment processing)
      // await Future.delayed(Duration(seconds: 10));
      if (response['status'] == 'error') {
        toast(response['message']);
      }

      if (response['status'] == 'success') {
        toast(response['message']);
        Get.off(() => ParcelPage(height: 0.85));
      }

      // Navigate to ParcelPage after payment is complete
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // Hide loader
    }
  }
}
