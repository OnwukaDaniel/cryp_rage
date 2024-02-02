import 'package:cryp_rage/backend/repo/getCryptoCurrencies.dart';
import 'package:cryp_rage/backend/repo/getCurrencies.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCryptoCurrenciesController = Provider((ref) {
  final entryRepo = ref.watch(getCryptoCurrenciesEntryRepo);
  return GetCryptoCurrenciesController(ref: ref, getCryptoCurrenciesEntryRepo: entryRepo);
});

class GetCryptoCurrenciesController {
  final ProviderRef ref;
  final GetCryptoCurrenciesEntryRepo getCryptoCurrenciesEntryRepo;

  GetCryptoCurrenciesController({
    required this.ref,
    required this.getCryptoCurrenciesEntryRepo,
  });

  Future<ApiResponse> getCryptoCurrenciesController() {
    return getCryptoCurrenciesEntryRepo.getCryptoCurrencies();
  }
}
