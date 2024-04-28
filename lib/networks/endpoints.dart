// ignore_for_file: constant_identifier_names

const String url = String.fromEnvironment("https://api.weatherapi.com/v1");

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

const String API_KEY = "e05371904e9a473f81c162021242704";

final class Endpoints {
  Endpoints._();
  //backend_url
  static const String baseUrl = 'https://api.weatherapi.com/v1';
  static String currentWeather(String? lat, String? lon) =>
      "/current.json?key=$API_KEY&q=$lat,$lon&aqi=no";
  static String forcastWeather(String? lat, String? lon) =>
      "/forecast.json?key=$API_KEY&q=$lat,$lon&days=4&aqi=no&alerts=no";
}
