import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/update_product_from_cart_data.dart';


class CounterOfItemsOfOrderCubit extends Cubit<int> {
  num subTotal = 0.0;
  final UpdateProductFromCartAccountData updateCount;
  bool isStartChange = false;
  CounterOfItemsOfOrderCubit({required this.updateCount}) : super(1);
  Future<void> increase(int number, int id) async {
    isStartChange = true;
    emit(++number);
    await updateCount(id, state);

  }

  Future<void> decrease(int number,int id) async {
    if (number > 1) {
      isStartChange = true;
      emit(--number);
      await updateCount(id, state);

    }
  }
}
