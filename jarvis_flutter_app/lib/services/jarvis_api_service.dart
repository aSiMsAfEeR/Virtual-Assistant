import 'dart:convert';
import 'package:http/http.dart' as http;

class JarvisApiService {
  // Change this to your Flask server IP address
  // For local testing: use your PC's IP address (e.g., 'http://192.168.1.100:5000')
  // For emulator: use 'http://10.0.2.2:5000' (Android) or 'http://localhost:5000' (iOS)
  static const String baseUrl = 'http://10.0.2.2:5000'; // Android emulator default

  Future<String> processCommand(String command, {bool speak = false}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/process'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'command': command,
          'speak': speak,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'No response received';
      } else {
        return 'Error: Server returned ${response.statusCode}';
      }
    } catch (e) {
      return 'Error connecting to Jarvis: $e';
    }
  }

  Future<List<String>> getMusicLibrary() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/music-library'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['songs'] ?? []);
      } else {
        return [];
      }
    } catch (e) {
      print('Error loading music library: $e');
      return [];
    }
  }
}
