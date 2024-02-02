import 'package:cryp_rage/backend/repo/getCurrencies.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCurrenciesController = Provider((ref) {
  final entryRepo = ref.watch(getCurrenciesEntryRepo);
  return GetCurrenciesController(ref: ref, getCurrenciesEntryRepo: entryRepo);
});

class GetCurrenciesController {
  final ProviderRef ref;
  final GetCurrenciesEntryRepo getCurrenciesEntryRepo;

  GetCurrenciesController({
    required this.ref,
    required this.getCurrenciesEntryRepo,
  });

  Future<ApiResponse> getCurrenciesController() {
    return getCurrenciesEntryRepo.getCurrencies();
  }
}
