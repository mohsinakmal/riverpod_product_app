import 'package:riverpod_files/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

// Notifier<Set<Product>> we initially exended it with this

@riverpod
class CartNotifier extends _$CartNotifier {
  // initial value
  @override
  Set<Product> build() {
    return const {};
  }

  // methods to update state
  // here ... is called spread operater which let's you add items
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  // this here iterates through set and creates new set containing all the values except where the two id's match
  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state
          .where(
            (p) => p.id != product.id,
          )
          .toSet();
    }
  }
}

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;

  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}


// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier();
// });
