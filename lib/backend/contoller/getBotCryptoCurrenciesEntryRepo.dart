import 'package:cryp_rage/backend/repo/getBotCryptoCurrencies.dart';
import 'package:cryp_rage/backend/repo/getCryptoCurrencies.dart';
import 'package:cryp_rage/backend/repo/getCurrencies.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getBotCryptoCurrenciesController = Provider((ref) {
  final entryRepo = ref.watch(getBotCryptoCurrenciesEntryRepo);
  return GetBotCryptoCurrenciesController(ref: ref, getBotCryptoCurrenciesEntryRepo: entryRepo);
});

class GetBotCryptoCurrenciesController {
  final ProviderRef ref;
  final GetBotCryptoCurrenciesEntryRepo getBotCryptoCurrenciesEntryRepo;

  GetBotCryptoCurrenciesController({
    required this.ref,
    required this.getBotCryptoCurrenciesEntryRepo,
  });

  Future<ApiResponse> getBotCryptoCurrenciesController() {
    return getBotCryptoCurrenciesEntryRepo.getBotCryptoCurrencies();
  }
}
