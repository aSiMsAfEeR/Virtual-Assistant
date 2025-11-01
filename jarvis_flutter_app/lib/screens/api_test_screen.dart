import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  String _result = 'Tap "Test Connection" to verify your Flask backend';
  bool _testing = false;
  final TextEditingController _urlController = TextEditingController(
    text: 'http://10.0.2.2:5000', // Default for Android emulator
  );

  Future<void> _testConnection() async {
    setState(() {
      _testing = true;
      _result = 'Testing connection...';
    });

    try {
      // Test basic connectivity
      final baseUrl = _urlController.text.trim();
      final response = await http.get(
        Uri.parse('$baseUrl/music-library'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = '✅ Success!\n\n'
              'Status: ${response.statusCode}\n'
              'Songs found: ${data['songs'].length}\n'
              'Songs: ${data['songs'].join(', ')}';
        });
      } else {
        setState(() {
          _result = '❌ Server Error\n\n'
              'Status: ${response.statusCode}\n'
              'Response: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _result = '❌ Connection Failed\n\n'
            'Error: $e\n\n'
            'Troubleshooting:\n'
            '1. Check Flask is running\n'
            '2. Verify IP address is correct\n'
            '3. For Android emulator, use http://10.0.2.2:5000\n'
            '4. For physical device, use your PC\'s IP\n'
            '5. Check firewall allows port 5000';
      });
    }

    setState(() => _testing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Connection Test'),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Backend URL',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText: 'http://10.0.2.2:5000',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testing ? null : _testConnection,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: _testing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Test Connection', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
