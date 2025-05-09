import 'dart:convert';

import 'package:clicks_interview_test/app/submission_form/data/model/form_model.dart';
import 'package:clicks_interview_test/app/submission_form/data/repositories/form_submission_repository.dart';
import 'package:clicks_interview_test/app/submission_form/presentation/widgets/custom_drop_down_field.dart';
import 'package:clicks_interview_test/app/submission_form/presentation/widgets/submit_button.dart';
import 'package:clicks_interview_test/app/submission_form/presentation/widgets/text_input_form_field.dart';
import 'package:clicks_interview_test/core/resources/pref_resources.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmissionFormScreen extends StatefulWidget {
  const SubmissionFormScreen({super.key});

  @override
  State<SubmissionFormScreen> createState() => _SubmissionFormScreenState();
}

class _SubmissionFormScreenState extends State<SubmissionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _service, _mobileNumber;
  bool isLoading = false;
  List<String> services = ['Consulting', 'Support', 'Automation'];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    final formData = FormModel(
      name: _name!,
      email: _email!,
      serviceSelected: _service!,
      mobileNumber: _mobileNumber!,
    );

    final prefs = await SharedPreferences.getInstance();
    final existingUsersJson = prefs.getStringList(PrefResources.user) ?? [];

    final isDuplicate = existingUsersJson.any((userJson) {
      final user = jsonDecode(userJson);
      return user['name'] == _name || user['email'] == _email;
    });

    if (isDuplicate && mounted) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Error'),
              content: Text('Name or Email already taken.'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Ok"),
                ),
              ],
            ),
      );
      return;
    }

    existingUsersJson.add(formData.toJson());
    await prefs.setStringList(PrefResources.user, existingUsersJson);

    setState(() => isLoading = true);
    final whatsappSuccess = await FormSubmissionRepository()
        .sendMessageAfterSubmission(formData: formData);
    setState(() => isLoading = false);

    final isFormSuccess = DateTime.now().second % 2 == 0;
    if (mounted) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(isFormSuccess ? 'Success' : 'Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isFormSuccess
                        ? 'Form submitted successfully.'
                        : 'Form submission failed. Try again.',
                  ),
                  SizedBox(height: 8),
                  Text(
                    whatsappSuccess.isSuccess
                        ? 'WhatsApp confirmation sent with ID ${whatsappSuccess.message}'
                        : 'WhatsApp confirmation failed.',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          whatsappSuccess.isSuccess
                              ? Colors.green
                              : Colors.orange,
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _name = _email = _service = _mobileNumber = null;
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0),
          child: Card(
            elevation: 5,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Service Request Form",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 20),
                      TextInputFormField(
                        label: "Full Name",

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) => _name = val,
                        hint: "eg: Jhon Wick",
                        textInputAction: TextInputAction.next,
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                      ),

                      SizedBox(height: 10),
                      TextInputFormField(
                        label: "Email",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hint: "eg: JhonWick@mail.com",
                        textInputAction: TextInputAction.next,
                        onSaved: (val) => _email = val,
                        validator:
                            (val) =>
                                val == null || !val.contains('@')
                                    ? 'Enter a valid email'
                                    : null,
                      ),
                      SizedBox(height: 10),
                      TextInputFormField(
                        label: "Mobile Number",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) => _mobileNumber = val,
                        hint: "eg: 9876543",
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                      ),
                      SizedBox(height: 10),
                      ServiceDropdown(
                        value: _service,
                        services: services,
                        onChanged: (val) => setState(() => _service = val),
                        labelText: "Available Services",
                        hintText: "Choose a service",
                        validator:
                            (val) =>
                                val == null
                                    ? 'Service selection required'
                                    : null,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: SubmitButton(
                          onPressed: _submit,
                          isLoading: isLoading,
                          label: "Submit",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
