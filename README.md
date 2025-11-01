# Jarvis - Virtual Assistant

A voice-enabled AI assistant with music library functionality built with Python, Flask, and OpenAI.

## Features

- Voice command recognition
- Text-to-speech responses
- Web browsing capabilities
- Music playback from library
- Web-based user interface
- OpenAI integration for advanced queries

## Setup

1. Create a virtual environment:
   ```
   python -m venv .venv
   ```

2. Activate the virtual environment:
   - Windows: `.venv\Scripts\activate`
   - macOS/Linux: `source .venv/bin/activate`

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Set your OpenAI API key (optional):
   - Create a `.env` file with your API key:
     ```
     OPENAI_API_KEY=your_api_key_here
     ```

## Usage

### Web Interface
Run the Flask web application:
```
python app.py
```
Then open your browser to http://localhost:5000

### Voice Assistant
Run the voice assistant:
```
python main.py
```
Say "Jarvis" to activate the assistant, then give it a command.

## Commands

- "open [website]" - Opens popular websites (youtube, google, github, etc.)
- "play [song]" - Plays a song from the music library
- "news" - Opens news website
- Any other query - Processed by OpenAI (if API key is provided)

## Music Library

Songs can be added to `musicLibrary.py` in the format:
```python
music = {
    "song_name": "youtube_link"
}
```