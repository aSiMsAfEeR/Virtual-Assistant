# Jarvis Flutter App Architecture

## Overview

The Jarvis Flutter app follows a clean, layered architecture with clear separation of concerns.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                       │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │   Home     │  │  API Test  │  │      Widgets           │ │
│  │  Screen    │  │   Screen   │  │  - Chat                │ │
│  └────────────┘  └────────────┘  │  - Input               │ │
│                                   │  - Quick Actions       │ │
│                                   │  - Music Library       │ │
│                                   └────────────────────────┘ │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                   STATE MANAGEMENT                           │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              JarvisProvider (ChangeNotifier)           │ │
│  │                                                        │ │
│  │  - messages: List<ChatMessage>                        │ │
│  │  - musicLibrary: List<String>                         │ │
│  │  - isLoading: bool                                    │ │
│  │  - speakEnabled: bool                                 │ │
│  │                                                        │ │
│  │  Methods:                                             │ │
│  │  - sendCommand(String)                                │ │
│  │  - loadMusicLibrary()                                 │ │
│  │  - toggleSpeak()                                      │ │
│  │  - clearMessages()                                    │ │
│  └────────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                     SERVICE LAYER                            │
│  ┌────────────────────────────────────────────────────────┐ │
│  │            JarvisApiService (HTTP Client)              │ │
│  │                                                        │ │
│  │  - baseUrl: String                                    │ │
│  │                                                        │ │
│  │  Methods:                                             │ │
│  │  - processCommand(String, bool) → Future<String>      │ │
│  │  - getMusicLibrary() → Future<List<String>>           │ │
│  └────────────────────────────────────────────────────────┘ │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ▼ HTTP/REST API
┌─────────────────────────────────────────────────────────────┐
│                     FLASK BACKEND                            │
│                   (Python Server)                            │
│                                                              │
│  Endpoints:                                                  │
│  - POST /process → Process commands                          │
│  - GET  /music-library → Get available songs                 │
│                                                              │
│  Features:                                                   │
│  - OpenAI integration                                        │
│  - Text-to-speech                                            │
│  - Web browser control                                       │
│  - Music playback                                            │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### Command Processing Flow

1. **User Input** → User types or speaks a command
2. **Widget** → InputWidget captures the command
3. **Provider** → JarvisProvider.sendCommand() is called
4. **Service** → JarvisApiService.processCommand() makes HTTP request
5. **Backend** → Flask processes command via /process endpoint
6. **Response** → Backend returns text response
7. **Service** → ApiService returns response to Provider
8. **Provider** → Adds response to messages list
9. **Widget** → ChatWidget displays new message
10. **UI Update** → Screen refreshes via ChangeNotifier

### Music Library Flow

1. **App Start** → JarvisProvider initialization
2. **Provider** → Calls loadMusicLibrary()
3. **Service** → GET request to /music-library
4. **Backend** → Returns list from musicLibrary.py
5. **Provider** → Updates musicLibrary state
6. **Widget** → MusicLibraryWidget rebuilds with songs

## Component Details

### Models
- **ChatMessage**: Represents a chat message
  - text: String
  - isUser: bool
  - timestamp: DateTime

### Providers (State Management)
- **JarvisProvider**: Central state manager using Provider pattern
  - Manages chat messages
  - Handles API calls
  - Controls UI state (loading, speaking)

### Services
- **JarvisApiService**: HTTP client for Flask API
  - Handles all network requests
  - Error handling and timeouts
  - JSON serialization/deserialization

### Screens
- **HomeScreen**: Main app screen with header and chat
- **ApiTestScreen**: Connection testing utility

### Widgets
- **ChatWidget**: Scrollable message list
- **InputWidget**: Text input + voice input + settings
- **QuickActionsWidget**: Pre-configured command buttons
- **MusicLibraryWidget**: Dynamic song list from backend

## Key Technologies

- **State Management**: Provider (ChangeNotifier pattern)
- **HTTP Client**: http package
- **Voice Input**: speech_to_text package
- **Navigation**: Flutter Navigator
- **UI Framework**: Material Design 3

## Design Patterns

1. **Provider Pattern**: For state management
2. **Repository Pattern**: ApiService abstracts data layer
3. **Observer Pattern**: ChangeNotifier for reactive UI
4. **Single Responsibility**: Each widget has one purpose

## Network Configuration

```
Flutter App (Client)
      ↓
   HTTP/REST
      ↓
Flask Server (http://IP:5000)
      ↓
   ├─ OpenAI API
   ├─ pyttsx3 (TTS)
   └─ webbrowser
```

## File Structure

```
lib/
├── main.dart                      # App entry & theme
├── models/
│   └── chat_message.dart         # Message data model
├── providers/
│   └── jarvis_provider.dart      # State management
├── services/
│   └── jarvis_api_service.dart   # HTTP client
├── screens/
│   ├── home_screen.dart          # Main screen
│   └── api_test_screen.dart      # Testing utility
└── widgets/
    ├── chat_widget.dart          # Message display
    ├── input_widget.dart         # User input
    ├── quick_actions_widget.dart # Quick buttons
    └── music_library_widget.dart # Music list
```

## Error Handling

- Network errors: Caught and displayed to user
- Timeouts: 10s for commands, 5s for music library
- Invalid responses: Graceful fallback messages
- Permission errors: User-friendly prompts

## Performance Optimizations

- Lazy loading of music library
- Debounced API calls
- Optimized rebuilds with Consumer
- Efficient list rendering with ListView.builder

## Future Enhancements

1. WebSocket for real-time updates
2. Local caching of responses
3. Command history with autocomplete
4. Custom themes and personalization
5. Background voice activation
6. Offline mode with queue
