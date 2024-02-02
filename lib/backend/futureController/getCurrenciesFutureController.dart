import 'package:cryp_rage/backend/contoller/getCurrenciesEntryRepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCurrenciesFutureController = FutureProvider((ref) async {
  return ref.watch(getCurrenciesController).getCurrenciesController();
});