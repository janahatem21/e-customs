import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:e_customs/features/customs/data/models/ocr_item_model.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import 'image_processor_service.dart';

@lazySingleton
class OcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final ImageProcessorService _imageProcessor;

  late final GenerativeModel _model;

  OcrService(this._imageProcessor) {
    _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-1.5-flash');
  }

  Future<List<OcrItemModel>> extractItemsFromImage(String imagePath) async {
    // 1. ML Kit Validation: Check if image contains readable text
    final inputImage = InputImage.fromFilePath(imagePath);
    final RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);

    if (recognizedText.text.trim().isEmpty) {
      throw NoTextDetectedException();
    }

    // 2. Compress Image
    final File? compressedFile =
        await _imageProcessor.compressImage(imagePath);
    if (compressedFile == null) {
      throw GeminiAnalysisException('Image compression failed');
    }

    try {
      // 3. Intelligent Analysis with Gemini Vision
      return await _analyzeImageWithVision(compressedFile);
    } catch (e) {
      dev.log(
        'Gemini Vision Analysis failed: $e',
        name: 'OcrService',
      );
      rethrow;
    }
  }

  Future<List<OcrItemModel>> _analyzeImageWithVision(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();

    final prompt = [
      Content.multi([
        TextPart(
          "You are an expert Customs Receipt Analyzer. Analyze the provided image of a shopping receipt visually.\n\n"
          "**Goal:** Extract a clean list of purchased products for customs declaration.\n\n"
          "**Instructions:**\n"
          "1. Detect only purchased items/products. Ignore store metadata, VAT/tax details, or payment info.\n"
          "2. Handle discounts and coupons: Extract the FINAL price paid for each item after any item-level discounts.\n"
          "3. For each item, provide: `name`, `price` (float), `quantity` (int), `currency` (3-letter code), and `category`.\n"
          "4. Assign one of these categories: ['Electronics', 'Clothing', 'Cosmetics', 'Appliances', 'Accessories', 'Other'].\n"
          "5. Avoid duplicate entries. If an item appears multiple times, combine them or list separately if prices differ.\n"
          "6. If the receipt is not a shopping receipt or is unreadable, return an empty array [].\n\n"
          "**Constraint:** Return the result strictly as a valid JSON array of objects. No markdown, no extra text.",
        ),
        InlineDataPart('image/jpeg', imageBytes),
      ]),
    ];

    final response = await _model.generateContent(prompt);
    final text = response.text;

    if (text == null || text.isEmpty) return [];

    // Clean JSON response (handle potential markdown formatting)
    final cleanedText =
        text.replaceAll('```json', '').replaceAll('```', '').trim();

    try {
      final decoded = jsonDecode(cleanedText);
      if (decoded is List) {
        return decoded.map((item) => OcrItemModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      dev.log('JSON Parsing Error', error: e, name: 'OcrService');
      throw GeminiAnalysisException('Failed to parse AI response');
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}
