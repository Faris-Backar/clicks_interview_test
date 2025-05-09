// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:clicks_interview_test/app/submission_form/data/model/form_model.dart';

class WhatsappMessageResponseModel {
  final bool isSuccess;
  final String message;

  WhatsappMessageResponseModel({
    required this.isSuccess,
    required this.message,
  });
}

class FormSubmissionRepository {
  final String apiVersion = 'v17.0';
  final String phoneNumberId = "phoneNumberId";
  final String accessToken = "AccessToken";
  final String baseUrl = 'https://graph.facebook.com';
  final Random _random = Random();

  Future<WhatsappMessageResponseModel> sendMessageAfterSubmission({
    required FormModel formData,
  }) async {
    try {
      final message =
          "Hi ${formData.name}, thanks for your interest in our ${formData.serviceSelected} service. We'll get in touch soon!";
      final payload = _createMessagePayload(formData.mobileNumber, message);
      final response = await _sendWhatsAppRequest(payload);

      final messageId = response['messages']?[0]?['id'];
      if (messageId != null) {
        return WhatsappMessageResponseModel(
          isSuccess: true,
          message: messageId,
        );
      } else {
        return WhatsappMessageResponseModel(
          isSuccess: false,
          message: "Message couldn't be delivered, please contact admin.",
        );
      }
    } catch (e) {
      return WhatsappMessageResponseModel(
        isSuccess: false,
        message: "Message couldn't be delivered, please contact admin.",
      );
    }
  }

  Map<String, dynamic> _createMessagePayload(
    String recipientPhone,
    String textMessage,
  ) {
    return {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": recipientPhone,
      "type": "text",
      "text": {"preview_url": false, "body": textMessage},
    };
  }

  Future<Map<String, dynamic>> _sendWhatsAppRequest(
    Map<String, dynamic> payload,
  ) async {
    final url = '$baseUrl/$apiVersion/$phoneNumberId/messages';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    // Simulate network request
    return await _mockWhatsAppResponse(payload);
  }

  Future<Map<String, dynamic>> _mockWhatsAppResponse(
    Map<String, dynamic> payload,
  ) async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
    final messageId = 'wamid.${_generateRandomString(28)}';
    final String to = payload['to'];
    return {
      'messaging_product': 'whatsapp',
      'contacts': [
        {'input': to, 'wa_id': to},
      ],
      'messages': [
        {'id': messageId},
      ],
    };
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
      List.generate(
        length,
        (_) => chars.codeUnitAt(_random.nextInt(chars.length)),
      ),
    );
  }
}
