import 'api_service.dart';

class ChatService {
  static Future<Map<String, dynamic>> getConversations() async {
    try {
      final response = await ApiService.get('/chat/conversations');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load conversations: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getMessages(String userId) async {
    try {
      final response = await ApiService.get('/chat/messages/$userId');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load messages: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> sendMessage({
    required String receiverId,
    required String content,
    String messageType = 'text',
  }) async {
    try {
      final response = await ApiService.post('/chat/send', {
        'receiverId': receiverId,
        'content': content,
        'messageType': messageType,
      });
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to send message: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> markAsRead(String messageId) async {
    try {
      final response = await ApiService.put('/chat/messages/$messageId/read', {});
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to mark message as read: $e',
      };
    }
  }
}
