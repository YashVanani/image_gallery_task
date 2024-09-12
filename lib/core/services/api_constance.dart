const String baseUrl = "https://pixabay.com/api/?key=45931167-86db137849fe2109bfdb2fd93";

class ApiConstants {
  String getImage({required String query, required int page}) {
    return "$baseUrl&q=$query&page=$page&image_type=photo";
  }
}
