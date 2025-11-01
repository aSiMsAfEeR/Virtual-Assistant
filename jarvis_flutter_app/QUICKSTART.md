# Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Start the Flask Backend
```bash
cd d:\1-Personal\Virtual-Assistant
python app.py
```

Wait for: `* Running on http://0.0.0.0:5000`

---

### Step 2: Configure the App

1. Find your computer's IP address:
   ```bash
   ipconfig
   ```
   Look for **IPv4 Address** (e.g., `192.168.1.100`)

2. Open `lib/services/jarvis_api_service.dart`

3. Update line 8:
   ```dart
   static const String baseUrl = 'http://YOUR_IP:5000';
   ```

   **Important:**
   - Android Emulator: Use `http://10.0.2.2:5000`
   - iOS Simulator: Use `http://localhost:5000`
   - Physical Device: Use `http://YOUR_IP:5000`

---

### Step 3: Run the App
```bash
cd jarvis_flutter_app
flutter run
```

---

## ✅ Test It Works

Try these commands:
- "open youtube"
- "open google"
- "play interstellar"
- "news"

---

## 🔧 Troubleshooting

**Can't connect to server?**
1. Make sure Flask is running
2. Test from phone browser: `http://YOUR_IP:5000`
3. Check firewall allows port 5000

**No microphone permission?**
- Go to: Settings > Apps > Jarvis > Permissions > Enable Microphone

**Music library empty?**
- Tap the refresh button
- Verify Flask backend has `musicLibrary.py`

---

## 📱 Building for Release

```bash
# Android APK
flutter build apk --release

# Find APK at:
# build/app/outputs/flutter-apk/app-release.apk
```

---

Enjoy your Jarvis assistant! 🤖
