import 'package:flutter/material.dart';

class ServiceDropdown extends StatelessWidget {
  final String? value;
  final List<String> services;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  const ServiceDropdown({
    super.key,
    required this.value,
    required this.services,
    required this.onChanged,
    this.labelText = "Services",
    this.hintText = "Select a preferred Service",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            fillColor: Theme.of(context).colorScheme.tertiaryContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
            errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w400,
            ),
          ),
          items:
              services
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
          onChanged: onChanged,
          validator:
              validator ?? (val) => val == null ? 'Select a service' : null,
        ),
      ],
    );
  }
}
