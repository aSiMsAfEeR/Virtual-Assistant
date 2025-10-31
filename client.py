from openai import OpenAI

# Replace this with your actual OpenAI API key from https://platform.openai.com/api-keys
client = OpenAI(api_key="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")

completion = client.chat.completions.create(
    model="gpt-4o-mini",  # Free and lightweight model available to all users
    messages=[
        {"role": "system", "content": "You are Jarvis, a virtual assistant skilled in general tasks such as opening websites, playing music, and providing news updates."},
        {"role": "user", "content": "What is coding?"}
    ]
)

print(completion.choices[0].message.content)
