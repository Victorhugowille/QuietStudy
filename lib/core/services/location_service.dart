
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationAnalysis {
  final String placeType;
  final bool isQuiet;
  final String recommendation;
  final String mapImageUrl;

  LocationAnalysis({
    required this.placeType,
    required this.isQuiet,
    required this.recommendation,
    required this.mapImageUrl,
  });
}

class LocationService {
  final String _apiKey = 'AIzaSyCAZPkthaMC3vLqGxctb0esSWiIvDeqLCQ';

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desabilitado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permissão de localização negada permanentemente.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<LocationAnalysis> analyzeCurrentLocation() async {
    try {
      final position = await _getCurrentPosition();
      final lat = position.latitude;
      final lng = position.longitude;

      final String mapUrl =
          'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x400&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=$_apiKey';

      final placesUrl = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=50&key=$_apiKey');

      final response = await http.get(placesUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        if (results.isNotEmpty) {
          final firstPlace = results.first;
          final types = firstPlace['types'] as List;
          final placeName = firstPlace['name'];

          return _classifyPlace(types, placeName, mapUrl);
        } else {
          return LocationAnalysis(
              placeType: 'Desconhecido',
              isQuiet: true,
              recommendation: 'Não encontramos um local específico, mas parece ser uma área residencial.',
              mapImageUrl: mapUrl);
        }
      } else {
        throw Exception('Falha ao contatar a API do Google Places.');
      }
    } catch (e) {
      rethrow;
    }
  }

  LocationAnalysis _classifyPlace(List<dynamic> types, String name, String mapUrl) {
    const quietTypes = {'library', 'book_store', 'university', 'church'};
    const noisyTypes = {'bar', 'night_club', 'stadium', 'airport', 'train_station', 'shopping_mall', 'amusement_park'};

    for (var type in types) {
      if (quietTypes.contains(type)) {
        return LocationAnalysis(
            placeType: name,
            isQuiet: true,
            recommendation: 'Excelente! Locais como bibliotecas e universidades são ótimos para se concentrar.',
            mapImageUrl: mapUrl);
      }
      if (noisyTypes.contains(type)) {
        return LocationAnalysis(
            placeType: name,
            isQuiet: false,
            recommendation: 'Atenção! Lugares como bares e shoppings costumam ser barulhentos.',
            mapImageUrl: mapUrl);
      }
    }

    if (types.contains('lodging') || types.contains('locality')) {
      return LocationAnalysis(
          placeType: 'Área Residencial',
          isQuiet: true,
          recommendation: 'Parece ser uma área residencial, que geralmente é um bom lugar para estudar.',
          mapImageUrl: mapUrl);
    }

    return LocationAnalysis(
        placeType: name,
        isQuiet: true,
        recommendation: 'Não conseguimos classificar com precisão, mas parece ser um local tranquilo.',
        mapImageUrl: mapUrl);
  }
}