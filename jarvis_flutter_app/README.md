# Jarvis Flutter App

A modern Flutter mobile application that interfaces with the Jarvis Python virtual assistant backend.

## Features

- 🎤 **Voice Input**: Use speech-to-text to give commands
- 💬 **Chat Interface**: Beautiful chat UI with message history
- ⚡ **Quick Actions**: One-tap shortcuts for common websites
- 🎵 **Music Library**: Play songs from your music collection
- 🔊 **Voice Response**: Optional text-to-speech responses (server-side)
- 🌐 **Web Integration**: Opens websites and plays YouTube music

## Prerequisites

1. **Flutter SDK** installed on your system
2. **Python Flask backend** running (from the main project)
3. Android/iOS device or emulator

## Setup Instructions

### 1. Start the Flask Backend

First, make sure your Python Flask server is running:

```bash
# In the main project directory
cd d:\1-Personal\Virtual-Assistant
python app.py
```

The server should start on `http://0.0.0.0:5000`

### 2. Configure the API Endpoint

Edit `lib/services/jarvis_api_service.dart` and update the `baseUrl`:

```dart
static const String baseUrl = 'http://YOUR_IP:5000';
```

**Important IP configurations:**

- **Android Emulator**: Use `http://10.0.2.2:5000`
- **iOS Simulator**: Use `http://localhost:5000`
- **Physical Device**: Use your computer's IP address (e.g., `http://192.168.1.100:5000`)

To find your IP address:
```bash
# Windows
ipconfig

# Look for "IPv4 Address" under your active network adapter
```

### 3. Install Dependencies

```bash
cd jarvis_flutter_app
flutter pub get
```

### 4. Run the App

```bash
# For Android
flutter run

# For iOS (macOS only)
flutter run -d ios

# For specific device
flutter devices  # List available devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── chat_message.dart       # Message model
├── providers/
│   └── jarvis_provider.dart    # State management
├── screens/
│   └── home_screen.dart        # Main screen
├── services/
│   └── jarvis_api_service.dart # API client
└── widgets/
    ├── chat_widget.dart        # Chat messages display
    ├── input_widget.dart       # Text/voice input
    ├── quick_actions_widget.dart # Quick action buttons
    └── music_library_widget.dart # Music library
```

## Features Explained

### Voice Input
- Tap the microphone icon to start voice recognition
- Speak your command
- The recognized text appears in the input field
- Tap send or speak another command

### Quick Actions
Pre-configured shortcuts for:
- YouTube, Google, Gmail
- GitHub, LinkedIn, ChatGPT
- News, ClickUp
- And more!

### Music Library
- Automatically loads from the backend
- Click any song to play it
- Songs open in the browser (YouTube links)

### Voice Response Toggle
- Enable/disable server-side text-to-speech
- Only works if Python TTS is configured on the server

## Network Configuration

### For Flask Backend (Python)

Make sure your Flask app is accessible from the network:

```python
if __name__ == '__main__':
    app.run(debug=True, port=5000, host='0.0.0.0')  # ✅ Correct
```

### Firewall Settings

Allow port 5000 through your firewall:

```bash
# Windows Firewall
netsh advfirewall firewall add rule name="Flask" dir=in action=allow protocol=TCP localport=5000
```

## Troubleshooting

### "Error connecting to Jarvis"

1. **Check Flask server is running**
   ```bash
   # Should see output like:
   # * Running on http://0.0.0.0:5000
   ```

2. **Verify IP address is correct**
   - For physical devices, use your computer's local IP
   - For emulator, use `10.0.2.2` (Android) or `localhost` (iOS)

3. **Test connection manually**
   ```bash
   # From your phone's browser, visit:
   http://YOUR_IP:5000
   
   # You should see the Jarvis web interface
   ```

4. **Check firewall settings**
   - Ensure port 5000 is open
   - Some antivirus software may block connections

### "Permission denied for microphone"

- Go to your device Settings > Apps > Jarvis > Permissions
- Enable Microphone permission

### Songs not loading

- Verify the Flask `/music-library` endpoint is working
- Check `musicLibrary.py` exists in the Python project
- Refresh the music library using the refresh button

## Commands You Can Try

- "open youtube"
- "open google"
- "play interstellar"
- "news"
- "what is the weather today?" (requires OpenAI)
- Any general question (if OpenAI API is configured)

## Permissions

The app requires the following Android permissions:
- **INTERNET**: To connect to the Flask backend
- **RECORD_AUDIO**: For voice input
- **ACCESS_NETWORK_STATE**: To check network connectivity

## Dependencies

```yaml
dependencies:
  flutter: sdk
  http: ^1.1.0              # HTTP requests
  provider: ^6.1.1          # State management
  speech_to_text: ^6.6.0    # Voice input
  url_launcher: ^6.2.2      # Open URLs
  animations: ^2.0.11       # Smooth animations
  intl: ^0.19.0             # Date formatting
```

## Building for Release

### Android APK
```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```

## Future Enhancements

- [ ] Dark mode support
- [ ] Command history
- [ ] Custom quick actions
- [ ] Offline mode
- [ ] Push notifications
- [ ] Background voice activation

## License

Same as the parent Jarvis project.

## Support

For issues related to:
- **Flutter app**: Check this README
- **Backend API**: See main project documentation
- **Voice recognition**: Ensure microphone permissions are granted
