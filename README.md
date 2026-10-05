# language_learning_app

A small, privacy-focused language learning app that runs locally on your phone.

There are plenty of language-learning apps available, but most rely on cloud services to process your voice and text. This means your conversations and other inputs are sent to remote servers.

This project takes a different approach: **run the models locally and keep your data on your device.**

The app combines several small, locally runnable models to create an interactive language-learning experience:

* **ASR (Automatic Speech Recognition)** : listens to and transcribes the user's speech.
* **LLM (Large Language Model)** : understands the conversation and generates responses, questions, and exercises.
* **TTS (Text-to-Speech)** : speaks responses back to the user.
* **Vision-Language Models (VLMs)** : understand the user's surroundings and use the visual context to start conversations and ask relevant questions.
* **Simple UI** : provides an easy way to interact with the system without needing to manage the individual models manually.

The key idea is that **all of the models are small enough to run comfortably on a typical phone**. No cloud-based inference is required, making the application both **private and accessible**.

The goal is to build a language-learning companion that can listen, speak, see, and interact with its environment—all while keeping the user's data local.

To avoid having all models run at the same time unnecessarily, the app will be similar to a chat app like whatsapp. The main part will be the chat, hence the LLM will always be loaded. If the user chooese to send a voice message, the ASR will be loaded (with a Time to live = 5 mins so that the model doesn't offload directly). The TTS will be loaded if the user clicked a reply from the bot to listen to it. If the user wants to have a "call" meaning he speaks with the app direclty and the app responds vocally, all ASR + LLM + TTS will be loaded. This way memory overload is avoided. Same thing is done with YOLO, the app only checks its environment the first time it is opened, then every 5 mins unless the user explicitly asked it to check again.

                      APP
                       │
        ┌──────────────┼──────────────────────────────────────────────┐
        ↓              ↓           ↓                 ↓                ↓
      Chat          Voice      Hearing the          Call             YOLO
        │           Message      reply               │                │
        ↓              ↓           ↓
      LLM            ASR          TTS          ASR + LLM + TTS      LiteRT
        │              │           │
     llama.cpp      Moonshine    LiteRT
        └──────────────┴───────────┴─────────────────┴────────────────┘
