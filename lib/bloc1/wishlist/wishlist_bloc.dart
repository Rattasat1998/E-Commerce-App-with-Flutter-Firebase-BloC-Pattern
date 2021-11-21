import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';


class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading());

  @override
  Stream<WishlistState> mapEventToState(
      WishlistEvent event,
      ) async* {
    if(event is StartWishlist){
      yield* _mapStartWishlistToState();
    } else if(event is AddWishlistProduct){
      yield* _mapAddWishlistToState(event,state);
    }
    else if(event is RemoveWishlistProduct){
      yield* _mapRemoveWishlistToState(event,state);
    }
  }

  Stream<WishlistState> _mapStartWishlistToState() async* {
    yield WishlistLoading();
    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const WishlistLoaded();
    }catch(_){}
  }
  Stream<WishlistState> _mapAddWishlistToState(AddWishlistProduct event,WishlistState state ) async* {
    if(state is WishlistLoaded){
      try{
        yield WishlistLoaded(wishlist: Wishlist(product: List.from(state.wishlist.product)..add(event.product!)));
      } catch (_){}
    }
  }
  Stream<WishlistState> _mapRemoveWishlistToState(RemoveWishlistProduct event,WishlistState state ) async* {
    if(state is WishlistLoaded){
      try{
        yield WishlistLoaded(wishlist: Wishlist(product: List.from(state.wishlist.product)..remove(event.product!)));
      } catch (_){}
    }
  }
}

