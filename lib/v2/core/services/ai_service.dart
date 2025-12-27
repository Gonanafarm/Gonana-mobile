import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/product_model.dart';

class AIService {
  static final AIService instance = AIService._internal();
  factory AIService() => instance;
  AIService._internal();

  GenerativeModel? _model;
  bool _initialized = false;
  String? _apiKey;

  bool get isInitialized => _initialized;

  // Initialize with API key
  void initialize(String apiKey) {
    if (apiKey.isEmpty || apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
      _initialized = false;
      _apiKey = null;
      return;
    }

    try {
      _model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
      );
      _apiKey = apiKey;
      _initialized = true;
    } catch (e) {
      _initialized = false;
      _apiKey = null;
    }
  }

  // Smart product search with natural language
  Future<String> searchProducts({
    required String query,
    required List<Product> availableProducts,
  }) async {
    if (!_initialized || _model == null) {
      return _getFallbackSearchResponse(query, availableProducts);
    }

    final productContext = availableProducts.take(20).map((p) {
      return '- ${p.title}: ₦${p.price}, ${p.category ?? 'General'}, ${p.description ?? "No description"}';
    }).join('\n');

    final prompt = '''
You are a helpful shopping assistant for Gonana, an agricultural marketplace in Nigeria.

User Query: "$query"

Available Products:
$productContext

Based on the user's query, recommend the most relevant products from the list above.
Respond in a friendly, conversational way. If the query is location-specific (like "near me"), 
acknowledge it but explain that all products are available for delivery.

Keep your response concise (2-3 sentences max) and mention specific product names.
''';

    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ??
          _getFallbackSearchResponse(query, availableProducts);
    } catch (e) {
      return _getFallbackSearchResponse(query, availableProducts);
    }
  }

  // Fallback search response when AI is unavailable
  String _getFallbackSearchResponse(String query, List<Product> products) {
    // Simple keyword matching
    final queryLower = query.toLowerCase();
    final matches = products
        .where((p) {
          return p.title.toLowerCase().contains(queryLower) ||
              (p.description?.toLowerCase().contains(queryLower) ?? false) ||
              (p.category?.toLowerCase().contains(queryLower) ?? false);
        })
        .take(3)
        .toList();

    if (matches.isEmpty) {
      return 'I couldn\'t find products matching "$query". Try browsing our categories or search for items like rice, tomatoes, or livestock.';
    }

    final productNames = matches.map((p) => p.title).join(', ');
    return 'I found these for you: $productNames. Tap on any product to see more details!';
  }

  // Get product recommendations
  Future<String> getRecommendations({
    required List<Product> userHistory,
    required List<Product> popularProducts,
  }) async {
    if (!_initialized || _model == null) {
      return _getFallbackRecommendations(popularProducts);
    }

    final historyText = userHistory.take(5).map((p) => p.title).join(', ');
    final popularText = popularProducts.take(10).map((p) {
      return '- ${p.title}: ₦${p.price}';
    }).join('\n');

    final prompt = '''
User previously viewed: $historyText

Popular products:
$popularText

Suggest 3 products the user might like. Be brief and friendly.
''';

    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? _getFallbackRecommendations(popularProducts);
    } catch (e) {
      return _getFallbackRecommendations(popularProducts);
    }
  }

  String _getFallbackRecommendations(List<Product> popularProducts) {
    final top3 = popularProducts.take(3).map((p) => p.title).join(', ');
    return 'Check out our popular products: $top3';
  }

  // Chat with AI about products
  Future<String> chat(String message, {List<Product>? products}) async {
    if (!_initialized || _model == null) {
      return _getFallbackChatResponse(message, products);
    }

    final context = products != null && products.isNotEmpty
        ? '\nAvailable products: ${products.take(10).map((p) => p.title).join(", ")}'
        : '';

    final prompt = '''
You are a helpful agricultural marketplace assistant in Nigeria.
Answer the user's question about farming, products, or the marketplace.
Be concise (2-3 sentences max) and friendly. $context

User: $message
''';

    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? _getFallbackChatResponse(message, products);
    } catch (e) {
      return _getFallbackChatResponse(message, products);
    }
  }

  String _getFallbackChatResponse(String message, List<Product>? products) {
    final messageLower = message.toLowerCase();

    // Simple keyword-based responses
    if (messageLower.contains('hello') ||
        messageLower.contains('hi') ||
        messageLower.contains('hey')) {
      return 'Hello! I\'m here to help you find agricultural products. What are you looking for today?';
    }

    if (messageLower.contains('price') || messageLower.contains('cost')) {
      return 'Prices vary by product. You can use our search and filters to find products in your budget!';
    }

    if (messageLower.contains('delivery') ||
        messageLower.contains('shipping')) {
      return 'We offer delivery for all products. Delivery details are shown during checkout.';
    }

    if (messageLower.contains('help')) {
      return 'I can help you find products, answer questions about farming, or guide you through the marketplace. What would you like to know?';
    }

    // Default response
    if (products != null && products.isNotEmpty) {
      return 'I can help you find products! We have ${products.length} items available. Try searching for specific items or browse by category.';
    }

    return 'I\'m here to help! You can ask me about products, farming tips, or how to use the marketplace.';
  }

  // Check if API key is configured
  String? validateApiKey() {
    if (_apiKey == null || _apiKey!.isEmpty) {
      return 'No API key configured';
    }
    if (_apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
      return 'Please replace with your actual Gemini API key';
    }
    if (!_initialized) {
      return 'API key invalid or initialization failed';
    }
    return null; // Valid
  }
}
