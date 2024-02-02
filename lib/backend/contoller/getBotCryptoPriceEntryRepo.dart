import 'package:cryp_rage/backend/repo/getBotCryptoPrice.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getBotCryptoPriceController = Provider((ref) {
  final entryRepo = ref.watch(getBotCryptoPriceEntryRepo);
  return GetBotCryptoPriceController(
    ref: ref,
    getBotCryptoPriceEntryRepo: entryRepo,
  );
});

class GetBotCryptoPriceController {
  final ProviderRef ref;
  final GetBotCryptoPriceEntryRepo getBotCryptoPriceEntryRepo;

  GetBotCryptoPriceController({
    required this.ref,
    required this.getBotCryptoPriceEntryRepo,
  });

  Future<ApiResponse> getBotCryptoPriceController(String pair) {
    return getBotCryptoPriceEntryRepo.getBotCrypto(pair);
  }
}
