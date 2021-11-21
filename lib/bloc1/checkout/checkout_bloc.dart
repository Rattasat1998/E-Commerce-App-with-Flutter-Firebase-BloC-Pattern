import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/repositories/checkout/checkout_repository.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc(
      {required CartBloc cartBloc,
      required CheckoutRepository checkoutRepository})
      : _cartBloc = cartBloc, // รถเข็น
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded   // ใน super จะตรวจสอบสถานะของบล็อกรถเข็น หากเป็นสถานะ CartLoaded จะนำสินค้าออกจาก บล็อกรถเข็น
            ? CheckoutLoaded(
        products: (cartBloc.state as CartLoaded).cart.products,
        subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
        deliveryFree: (cartBloc.state as CartLoaded).cart.deliveryFreeString,
        total: (cartBloc.state as CartLoaded).cart.totalString,
      )
            : CheckoutLoading()){ // รอฟังเมื่อมีสินค้าเพิ่มในรถเข็น จะทำการอัปเดท สินค้าล่าสุดเข้ามา และ เพื่อให้แน่ใจว่าทุกอย่างเป็นปัจจุบัน
    _cartSubscription = cartBloc.stream.listen((event) {
      if(event is CartLoaded){
        add(UpdateCheckout(cart: event.cart));
      }
    });
  }

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if(event is UpdateCheckout){
      yield* _mapUpdateCheckoutToState(event, state);
    }
    if(event is ConfirmCheckout){
      yield* _mapConfirmCheckoutToState(event, state);
    }
  }

  Stream<CheckoutState> _mapUpdateCheckoutToState(UpdateCheckout event, CheckoutState state) async*{
    if(state is CheckoutLoaded){
      yield CheckoutLoaded(
        email: state.email,
        fullName: event.fullName ?? state.fullName,
        products: event.cart?.products ?? state.products,
        deliveryFree: event.cart?.deliveryFreeString ?? state.deliveryFree,
        subtotal: event.cart?.subtotalString ?? state.subtotal,
        total: event.cart?.totalString ?? state.total,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipCode: event.zipCode ?? state.zipCode,
      );
    }
  }

  Stream<CheckoutState> _mapConfirmCheckoutToState(ConfirmCheckout event, CheckoutState state) async*{
    _checkoutSubscription?.cancel(); // ยกเลิกการสมัครชำระเงิน
    if(state is CheckoutLoaded){
      try{
          await _checkoutRepository.addCheckout(event.checkout);
          print('Done');
         yield CheckoutLoading();
      } catch (_){}
    }
  }
}
