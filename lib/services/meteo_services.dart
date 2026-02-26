import 'package:dio/dio.dart';
import 'package:appmeteo/services/meteo_api_services.dart';
import 'package:appmeteo/models/ville.dart';
import 'package:appmeteo/utils/constantes.dart';

class MeteoService {
  final MeteoApiServices _api = MeteoApiServices(Dio());

  Future<Ville> getVille(String nomVille) async {
    final data = await _api.getVille(
      nomVille,
      Constants.apiKey,
      'fr',
      'metric',
    );
    return Ville.fromJson(data as Map<String, dynamic>);
  }
}
