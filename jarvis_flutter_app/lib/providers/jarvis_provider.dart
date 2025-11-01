import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import '../services/jarvis_api_service.dart';

class JarvisProvider extends ChangeNotifier {
  final JarvisApiService _apiService = JarvisApiService();
  final List<ChatMessage> _messages = [];
  List<String> _musicLibrary = [];
  bool _isLoading = false;
  bool _speakEnabled = true;

  List<ChatMessage> get messages => _messages;
  List<String> get musicLibrary => _musicLibrary;
  bool get isLoading => _isLoading;
  bool get speakEnabled => _speakEnabled;

  JarvisProvider() {
    _initialize();
  }

  void _initialize() {
    _messages.add(ChatMessage(
      text: "Hello! I'm Jarvis. I can help you open websites, play music, get news, and answer questions. How can I assist you today?",
      isUser: false,
    ));
    loadMusicLibrary();
  }

  Future<void> loadMusicLibrary() async {
    _musicLibrary = await _apiService.getMusicLibrary();
    notifyListeners();
  }

  void toggleSpeak() {
    _speakEnabled = !_speakEnabled;
    notifyListeners();
  }

  Future<void> sendCommand(String command) async {
    if (command.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: command, isUser: true));
    _isLoading = true;
    notifyListeners();

    // Process command
    final response = await _apiService.processCommand(command, speak: _speakEnabled);

    // Add assistant response
    _messages.add(ChatMessage(text: response, isUser: false));
    _isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    _initialize();
  }
}
