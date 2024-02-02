import 'package:cryp_rage/backend/contoller/getBotNGNCryptoPriceEntryRepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getBotNGNCryptoCurrenciesFutureController = FutureProvider((ref) async {
  return ref
      .watch(getBotNGNCryptoPriceController)
      .getBotNGNCryptoPriceController();
});
