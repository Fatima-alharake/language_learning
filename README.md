# language_learning

A small, privacy-focused language learning app that runs locally on your laptop.

There are plenty of language-learning apps available, but most rely on cloud services to process your voice and text. This means your conversations and other inputs are sent to remote servers.

This project takes a different approach: **run the models locally and keep your data on your device.**

The app combines several small, locally runnable models to create an interactive language-learning experience:

* **ASR (Automatic Speech Recognition)** : listens to and transcribes the user's speech.
* **LLM (Large Language Model)** : understands the conversation and generates responses, questions, and exercises.
* **TTS (Text-to-Speech)** : speaks responses back to the user.
* **Vision-Language Models (VLMs)** : understand the user's surroundings and use the visual context to start conversations and ask relevant questions.
* **Simple UI** : provides an easy way to interact with the system without needing to manage the individual models manually.

The key idea is that **all of the models are small enough to run comfortably on a typical laptop**. No cloud-based inference is required, making the application both **private and accessible**.

The goal is to build a language-learning companion that can listen, speak, see, and interact with its environment—all while keeping the user's data local.
