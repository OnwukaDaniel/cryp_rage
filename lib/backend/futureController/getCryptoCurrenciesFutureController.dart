import 'package:cryp_rage/backend/contoller/getCryptoCurrenciesEntryRepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCryptoCurrenciesFutureController = FutureProvider((ref) async {
  return ref.watch(getCryptoCurrenciesController).getCryptoCurrenciesController();
});