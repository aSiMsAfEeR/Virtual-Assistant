import os
from openai import OpenAI
import speech_recognition as sr
import webbrowser
import pyttsx3
import musicLibrary

recognizer = sr.Recognizer()
engine = pyttsx3.init()

# Initialize OpenAI client (optional - for advanced queries)
try:
    client = OpenAI(api_key=os.getenv("OPENAI_API_KEY", "YOUR_API_KEY_HERE"))
    openai_available = True
except:
    openai_available = False

def speak(text):
    engine.say(text)
    engine.runAndWait()

def processCommand(c):
    if 'open youtube' in c.lower():
        speak("Opening YouTube")
        webbrowser.open("https://www.youtube.com")
    elif 'open google' in c.lower():
        speak("Opening Google")
        webbrowser.open("https://www.google.com")
    elif 'open linkedin' in c.lower():
        speak("Opening LinkedIn")
        webbrowser.open("https://www.linkedin.com")
    elif 'open github' in c.lower():
        speak("Opening GitHub")
        webbrowser.open("https://www.github.com")   
    elif 'open gmail' in c.lower():
        speak("Opening Gmail")
        webbrowser.open("https://mail.google.com")
    elif 'open chatgpt' in c.lower():
        speak("Opening ChatGPT")
        webbrowser.open("https://chat.openai.com")
    elif 'open canva' in c.lower():
        speak("Opening Canva")
        webbrowser.open("https://www.canva.com")
    elif 'open poul3y' in c.lower():
        speak("Opening Poul3y")
        webbrowser.open("https://www.poul3y.com")
    elif 'open florid hotel' in c.lower():
        speak("Opening Florid Hotel")
        webbrowser.open("https://www.floridhotel.com")
    elif 'open clickup' in c.lower():
        speak("Opening ClickUp")
        webbrowser.open("https://www.clickup.com")
    elif c.lower().startswith("play"):
        try:
            song = c.lower().split(" ")[1]
            if song in musicLibrary.music:
                link = musicLibrary.music[song]
                webbrowser.open(link)
                speak(f"Playing {song}")
            else:
                speak(f"Song {song} not found in library")
        except IndexError:
            speak("Please specify a song name")
    elif "news" in c.lower():
        speak("Opening News")
        webbrowser.open("https://news.google.com/home")
    else:
        # Use OpenAI for other queries
        if openai_available:
            try:
                completion = client.chat.completions.create(
                    model="gpt-4o-mini",
                    messages=[
                        {"role": "system", "content": "You are Jarvis, a virtual assistant skilled in general tasks. Provide brief, helpful responses."},
                        {"role": "user", "content": c}
                    ]
                )
                response = completion.choices[0].message.content
                speak(response)
            except Exception as e:
                speak("I didn't understand that command. Try 'open [website]' or 'play [song]'")
        else:
            speak("I didn't understand that command. Try 'open [website]' or 'play [song]'")

if __name__=="__main__": 
    speak("Initializing Jarvis....")
    while True:
        # Listen for the wake word "Jarvis"
        print("Recognizing...")
        try:
            with sr.Microphone() as source:
                print("Listening...")
                audio = recognizer.listen(source, timeout=2, phrase_time_limit=1)
            word = recognizer.recognize_google(audio)
            if(word.lower() == "jarvis"):
                speak("Yes sir")
                # listen for the command
                with sr.Microphone() as source:
                    print("Jarvis Active...")
                    audio = recognizer.listen(source)
                    command = recognizer.recognize_google(audio)
                    processCommand(command)
        except sr.UnknownValueError:
            print("Could not understand audio")
        except sr.RequestError as e:
            print(f"Could not request results; {e}")
        except Exception as e:
            print(f"Error: {e}")