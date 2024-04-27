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

final class Endpoints {
  Endpoints._();
  //backend_url
  static String currentWeather() =>
      "/current.json?key=e05371904e9a473f81c162021242704&q=London&aqi=no";
  static String forcastWeather() =>
      "/forecast.json?key=e05371904e9a473f81c162021242704&q=London&days=1&aqi=no&alerts=no";
}
