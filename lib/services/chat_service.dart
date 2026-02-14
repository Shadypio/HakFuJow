import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/pdf_document.dart';

class ChatService {
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  String? _pdfContext;
  GenerativeModel? _model;

  Future<void> initialize() async {
    if (_pdfContext != null) return;
    _pdfContext = await _extractAllPdfText();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(
        'You are the official assistant for the HakFuJow Kung Fu Academy. '
        'You have deep knowledge of the academy based on the documents provided below. '
        'Use this document content to answer questions accurately and thoroughly. '
        'If a question is not covered by the documents, say you don\'t know but would be happy to help with any other questions about the academy. '
        'If a question is not covered by the documents but is about general kung fu knowledge, answer based on your general knowledge. '
        'Always respond in the same language as the user\'s question. '
        'Be friendly, professional, and give detailed answers when the documents contain relevant information. '
        'When quoting rules or information, reference which document it comes from.\n\n'
        'DOCUMENTS:\n$_pdfContext',
      ),
    );
  }

  Future<String> ask(String question) async {
    if (_model == null) await initialize();

    try {
      final response = await _model!.generateContent([Content.text(question)]);
      return response.text ?? 'No response received.';
    } catch (e) {
      debugPrint('Gemini error: $e');
      return 'Error: $e';
    }
  }

  Future<String> _extractAllPdfText() async {
    final buffer = StringBuffer();

    for (final doc in PdfDocument.samples) {
      try {
        final data = await rootBundle.load(doc.assetPath);
        final pdfDoc = sf.PdfDocument(inputBytes: data.buffer.asUint8List());
        final text = sf.PdfTextExtractor(pdfDoc).extractText();
        debugPrint('Extracted text from ${doc.title}:\n$text\n---');
        pdfDoc.dispose();
        buffer.writeln('--- ${doc.title} ---');
        buffer.writeln(text);
        buffer.writeln();
      } catch (e) {
        buffer.writeln('--- ${doc.title} ---');
        buffer.writeln('[Could not extract text]');
      }
    }

    return buffer.toString();
  }
}
