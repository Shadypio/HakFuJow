# HakFuJow 🥋

A mobile app for the **HakFuJow Kung Fu Academy**, built with Flutter for Android and iOS.

Browse official academy documents — training guides, rules, and philosophy — directly from your phone. An integrated AI chatbot lets you ask questions about the content of the documents and get instant answers.

## Screenshot
<img width="576" height="1150" alt="image" src="https://github.com/user-attachments/assets/8765fe78-c273-493d-b8c3-605390b7d417" />
<img width="576" height="1198" alt="image" src="https://github.com/user-attachments/assets/23f4d8b4-0dfc-42f2-ab49-1dc469d6aafe" />
<img width="576" height="1191" alt="image" src="https://github.com/user-attachments/assets/6edee89d-4f4f-45ab-a005-52a957053215" />




## Features

- **PDF Reader** — View kung fu academy documents with full-screen reading, page navigation, and in-document text search.
- **AI Chatbot** — Ask questions about the academy documents and get answers powered by Google Gemini. The chatbot extracts knowledge from all bundled PDFs and responds based on their content.
- **Offline PDF Access** — Documents are bundled as local assets, no internet needed to read them.
- **Search** — Search for keywords inside any PDF with real-time results and match navigation.

## Project Structure

```
lib/
├── main.dart                        # App entry point
├── theme/app_theme.dart             # Color palette & Material 3 theme
├── models/pdf_document.dart         # PDF document model
├── screens/home_screen.dart         # Home screen with document list
├── screens/pdf_viewer_screen.dart   # PDF viewer with search
├── screens/chat_screen.dart         # AI chatbot interface
└── services/chat_service.dart       # Gemini API integration & PDF text extraction
```

## Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/Shadypio/HakFuJow.git
   cd HakFuJow
   ```

2. **Add your Gemini API key**
   Create a `.env` file in the project root:
   ```
   GEMINI_API_KEY=your_api_key_here
   ```
   Get a free key at [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

3. **Add PDF documents**
   Place your PDF files in `assets/pdfs/` and register them in `lib/models/pdf_document.dart`.

4. **Install dependencies & run**
   ```bash
   flutter pub get
   flutter run
   ```

## Tech Stack

- **Flutter** — Cross-platform mobile framework
- **Syncfusion Flutter PDF Viewer** — PDF rendering and text search
- **Google Generative AI (Gemini)** — Chatbot intelligence
- **Material 3** — Modern UI design system

## License

This project is for internal use by the HakFuJow Kung Fu Academy.
