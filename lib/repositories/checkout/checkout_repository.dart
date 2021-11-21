import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/checkout_model.dart';
import 'package:ecom/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRepository{
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> addCheckout(Checkout checkout) {
    // TODO: implement addCheckout
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }

}