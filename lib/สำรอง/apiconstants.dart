import 'dart:convert';
import 'package:app_shoe/Services/apiservice.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;

  ApiResponse({required this.success, this.data, this.message});
}

class ApiService {
  Future<ApiResponse> post(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(success: true, data: responseBody);
      } else {
        return ApiResponse(
          success: false,
          message: responseBody['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      return ApiResponse(success: false, message: 'Connection error');
    }
  }
}
