import speech_recognition as sr
import webbrowser
import pyttsx3
import musicLibrary

recognizer = sr.Recognizer()
engine = pyttsx3.init()
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
        song = c.lower().split(" ")[1]
        link = musicLibrary.music[song]
        webbrowser.open(link)
        speak(f"Playing {song}")
    elif "news" in c.lower().startswith("news"):
        speak("Opening News")
        webbrowser.open("https://news.google.com/home")
    
    else:
        # Let OpenAI handle other commands
        pass

if __name__=="__main__": 
    speak("Initializing Jarvis....")
    while True:
        # Listen for the wake word "Jarvis"
        # obtainfrom the microphone
        r = sr.Recognizer()
       

        print("Recognizing...")
        try:
            with sr.Microphone() as source:
                print("Listening...")
                audio = r.listen(source, timeout=2, phrase_time_limit=1)
            word = r.recognize_google(audio)
            if(word.lower() == "jarvis"):
                speak("yes sir")
                # listen for the command
                with sr.Microphone() as source:
                    print("Jarvis Active...")
                    audio = r.listen(source)
                    command = r.recognize_google(audio)

                    processCommand(command)


        except Exception as e:
            print("Error; {0}".format(e))
