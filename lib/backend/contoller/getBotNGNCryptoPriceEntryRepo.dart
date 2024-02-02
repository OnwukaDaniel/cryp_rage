import 'package:cryp_rage/backend/repo/getBotCryptoPrice.dart';
import 'package:cryp_rage/backend/repo/getBotNGNCryptoPrice.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getBotNGNCryptoPriceController = Provider((ref) {
  final entryRepo = ref.watch(getBotNGNCryptoPriceEntryRepo);
  return GetBotNGNCryptoPriceController(
    ref: ref,
    getBotNGNCryptoPriceEntryRepo: entryRepo,
  );
});

class GetBotNGNCryptoPriceController {
  final ProviderRef ref;
  final GetBotNGNCryptoPriceEntryRepo getBotNGNCryptoPriceEntryRepo;

  GetBotNGNCryptoPriceController({
    required this.ref,
    required this.getBotNGNCryptoPriceEntryRepo,
  });

  Future<ApiResponse> getBotNGNCryptoPriceController() {
    return getBotNGNCryptoPriceEntryRepo.getBotNGNCrypto();
  }
}
