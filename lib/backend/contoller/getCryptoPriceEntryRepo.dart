import 'package:cryp_rage/backend/repo/getCryptoPrice.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getCryptoPriceController = Provider((ref) {
  final entryRepo = ref.watch(getCryptoPriceEntryRepo);
  return GetCryptoPriceController(ref: ref, getCryptoPriceEntryRepo: entryRepo);
});

class GetCryptoPriceController {
  final ProviderRef ref;
  final GetCryptoPriceEntryRepo getCryptoPriceEntryRepo;

  GetCryptoPriceController({
    required this.ref,
    required this.getCryptoPriceEntryRepo,
  });

  Future<ApiResponse> getCryptoPriceController(String pair) {
    return getCryptoPriceEntryRepo.getCrypto(pair);
  }
}
