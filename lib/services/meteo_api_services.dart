import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'meteo_api_services.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/')
abstract class MeteoApiServices {
  factory MeteoApiServices(Dio dio) = _MeteoApiServices;

  @GET('weather')
  @DioResponseType(ResponseType.json)
  Future<dynamic> getVille(
    @Query('q') String ville,
    @Query('appid') String apiKey,
    @Query('lang') String lang,
    @Query('units') String units,
  );
}
