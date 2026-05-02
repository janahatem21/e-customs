import 'dart:convert';
import 'dart:developer' as dev;
import 'package:e_customs/features/customs/data/models/ocr_item_model.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  late final GenerativeModel _model;

  OcrService() {
    // Migration: Using firebase_ai (v3.11.0+) which supports Gemini 2.5 Flash
    // We use FirebaseAI.googleAI() to connect via Google AI provider
    _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
  }

  Future<List<OcrItemModel>> extractItemsFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText = await _textRecognizer.processImage(
      inputImage,
    );

    final String rawText = recognizedText.text;

    if (rawText.trim().isEmpty) {
      return [];
    }

    try {
      // 1. Try Intelligent Parsing with Gemini 2.5 Flash
      return await _extractItemsWithAI(rawText);
    } catch (e) {
      // 2. Log the specific error (e.g., Quota Exceeded or Model Error)
      dev.log(
        'Gemini AI failed, switching to Manual Fallback. Reason: $e',
        name: 'OcrService',
      );

      // 3. Fallback to manual parsing if AI fails
      return _fallbackManualParsing(recognizedText);
    }
  }

  Future<List<OcrItemModel>> _extractItemsWithAI(String rawText) async {
    final prompt = [
      Content.text(
        "You are an expert Customs Declaration Assistant. Your task is to parse raw OCR text from a shopping receipt into a structured JSON format.\n\n"
        "**Rules:**\n"
        "1. Extract a list of items. Each item must have: `name`, `price` (double), `quantity` (int), and `category`.\n"
        "2. **Categories:** You must assign each item to one of these categories: ['Mobile', 'Laptop', 'Clothing', 'Electronics', 'Cosmetics']. If an item doesn't fit, use your intelligence to suggest a relevant high-level category (e.g., 'Accessories', 'Appliances') but keep it relevant to customs-taxable goods.\n"
        "3. Ignore non-item text like store address, VAT numbers, total sum, or footer notes.\n"
        "4. Ensure the output is ONLY a valid JSON array of objects.\n\n"
        "Raw OCR Text:\n$rawText",
      ),
    ];

    final response = await _model.generateContent(prompt);
    final text = response.text;

    if (text == null || text.isEmpty) return [];

    final cleanedText =
        text.replaceAll('```json', '').replaceAll('```', '').trim();

    try {
      final List<dynamic> jsonList = jsonDecode(cleanedText);
      return jsonList.map((item) => OcrItemModel.fromJson(item)).toList();
    } catch (e) {
      dev.log('JSON Parsing Error', error: e, name: 'OcrService');
      throw Exception('Invalid AI response format');
    }
  }

  List<OcrItemModel> _fallbackManualParsing(RecognizedText recognizedText) {
    final List<OcrItemModel> items = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        try {
          final item = OcrItemModel.fromTextLine(line.text);
          items.add(item);
        } catch (_) {
          continue;
        }
      }
    }
    return items;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
