# Form Registration Flutter Application

A Flutter application that handles user registration with WhatsApp Business API integration for communication follow-up.

## Overview

This mobile application built with Flutter provides a user registration form that collects essential information from users and processes it through the WhatsApp Business API integration. The FormSubmissionRepository currently implements mock functionality to simulate API interactions during development.

## Features

- User-friendly registration form built with Flutter
- Form validation for all input fields
- WhatsApp Business API integration for follow-up communication
- Service selection via dropdown menu
- Responsive design optimised for web.

## Form Details

The registration form includes the following fields:
- **Name**: User's full name
- **Email**: User's email address
- **Mobile**: User's mobile number for WhatsApp communication
- **Services**: Dropdown selection of available services

## WhatsApp Business API Integration

The application uses the WhatsApp Business API to send follow-up messages to users after successful form submission. Currently, this functionality is mocked in the `FormSubmissionRepository` for development purposes.

### Message Content Template

After successful form submission, the following message is sent to the user's WhatsApp:
```
"Hi {name}, thanks for your interest in our {service} service. We'll get in touch soon!"
```


#### WhatsApp Business API Payload Structure

The WhatsApp Cloud API requires a specific JSON payload structure:

```json
{
  "messaging_product": "whatsapp",
  "recipient_type": "individual",
  "to": "{recipient_phone_number}",
  "type": "text",
  "text": {
    "preview_url": false,
    "body": "Hi {name}, thanks for your interest in our {service} service. We'll get in touch soon!"
  }
}
```

#### Required Headers and Authorization

To authenticate with the WhatsApp Cloud API, the following headers are needed:

- `Authorization`: Bearer {access_token}
- `Content-Type`: application/json

#### Key Components for Integration

1. **Phone Number ID**: Your WhatsApp Business account's phone number ID
2. **Access Token**: Your Meta/Facebook developer account access token
3. **API Version**: Currently using v16.0 of the Graph API
4. **Endpoint**: `https://graph.facebook.com/v16.0/{phone-number-id}/messages` ( here Mocked API endpoint.).

The `FormSubmissionRepository` handles this integration by:
- Formatting the API payload with user data
- Setting appropriate headers
- Making the API request
- Handling success/failure responses

## Setup and Installation

1. Ensure you have Flutter installed on your machine
   ```
   flutter --version
   ```

2. Clone the repository
   ```
   git clone https://github.com/Faris-Backar/clicks_interview_test.git
   ```

3. Navigate to the project directory
   ```
   cd clicks_interview_test
   ```

4. Get dependencies
   ```
   flutter pub get
   ```

5. Run the application
   ```
   flutter run
   ```
## Project Repository

Official repository: [https://github.com/Faris-Backar/clicks_interview_test](https://github.com/Faris-Backar/clicks_interview_test)