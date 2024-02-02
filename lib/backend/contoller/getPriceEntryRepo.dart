import 'package:cryp_rage/backend/repo/getCurrencies.dart';
import 'package:cryp_rage/backend/repo/getSpotPrice.dart';
import 'package:cryp_rage/backend/reponse/ApiResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getPairPriceController = Provider((ref) {
  final entryRepo = ref.watch(getPairPriceEntryRepo);
  return GetPairPriceController(ref: ref, getPairPriceEntryRepo: entryRepo);
});

class GetPairPriceController {
  final ProviderRef ref;
  final GetPairPriceEntryRepo getPairPriceEntryRepo;

  GetPairPriceController({
    required this.ref,
    required this.getPairPriceEntryRepo,
  });

  Future<ApiResponse> getPairPriceController(String pair) {
    return getPairPriceEntryRepo.getPrice(pair);
  }
}