from flask import Flask, render_template, request, jsonify
import webbrowser
import pyttsx3
import musicLibrary
from openai import OpenAI
import os

app = Flask(__name__)

# Initialize text-to-speech engine
engine = pyttsx3.init()

# Initialize OpenAI client (optional - for advanced queries)
try:
    client = OpenAI(api_key=os.getenv("OPENAI_API_KEY", "YOUR_API_KEY_HERE"))
    openai_available = True
except:
    openai_available = False

def speak(text):
    """Text-to-speech function"""
    try:
        engine.say(text)
        engine.runAndWait()
    except Exception as e:
        print(f"TTS Error: {e}")

def processCommand(command):
    """Process user commands and return response"""
    c = command.lower()
    
    if 'open youtube' in c:
        webbrowser.open("https://www.youtube.com")
        return "Opening YouTube"
    elif 'open google' in c:
        webbrowser.open("https://www.google.com")
        return "Opening Google"
    elif 'open linkedin' in c:
        webbrowser.open("https://www.linkedin.com")
        return "Opening LinkedIn"
    elif 'open github' in c:
        webbrowser.open("https://www.github.com")
        return "Opening GitHub"
    elif 'open gmail' in c:
        webbrowser.open("https://mail.google.com")
        return "Opening Gmail"
    elif 'open chatgpt' in c:
        webbrowser.open("https://chat.openai.com")
        return "Opening ChatGPT"
    elif 'open canva' in c:
        webbrowser.open("https://www.canva.com")
        return "Opening Canva"
    elif 'open poul3y' in c:
        webbrowser.open("https://www.poul3y.com")
        return "Opening Poul3y"
    elif 'open florid hotel' in c:
        webbrowser.open("https://www.floridhotel.com")
        return "Opening Florid Hotel"
    elif 'open clickup' in c:
        webbrowser.open("https://www.clickup.com")
        return "Opening ClickUp"
    elif c.startswith("play"):
        try:
            song = c.split(" ")[1]
            if song in musicLibrary.music:
                link = musicLibrary.music[song]
                webbrowser.open(link)
                return f"Playing {song}"
            else:
                return f"Song '{song}' not found in library. Available songs: {', '.join(musicLibrary.music.keys())}"
        except IndexError:
            return "Please specify a song name"
    elif "news" in c:
        webbrowser.open("https://news.google.com/home")
        return "Opening News"
    else:
        # Use OpenAI for other queries
        if openai_available:
            try:
                completion = client.chat.completions.create(
                    model="gpt-4o-mini",
                    messages=[
                        {"role": "system", "content": "You are Jarvis, a virtual assistant skilled in general tasks. Provide brief, helpful responses."},
                        {"role": "user", "content": command}
                    ]
                )
                return completion.choices[0].message.content
            except Exception as e:
                return f"I didn't understand that command. Try 'open [website]' or 'play [song]'"
        else:
            return "I didn't understand that command. Try 'open [website]' or 'play [song]'"

@app.route('/')
def index():
    """Render the main page"""
    return render_template('index.html')

@app.route('/process', methods=['POST'])
def process():
    """Process command from the UI"""
    data = request.json
    if data is None:
        return jsonify({'response': 'No data received'})
        
    command = data.get('command', '') if data else ''
    
    if not command:
        return jsonify({'response': 'No command received'})
    
    response = processCommand(command)
    
    # Optional: speak the response
    speak_response = data.get('speak', False) if data else False
    if speak_response:
        speak(response)
    
    return jsonify({'response': response})

@app.route('/music-library', methods=['GET'])
def get_music_library():
    """Return available songs"""
    return jsonify({'songs': list(musicLibrary.music.keys())})

if __name__ == '__main__':
    app.run(debug=True, port=5000, host='0.0.0.0')