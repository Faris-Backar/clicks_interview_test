import 'package:clicks_interview_test/core/extensions/app_extension.dart';
import 'package:flutter/material.dart';

class TextInputFormField extends StatelessWidget {
  const TextInputFormField({
    super.key,
    this.hint,
    this.label,

    this.textInputAction,
    this.onChanged,
    this.fillColor,
    this.borderRadius,
    this.validator,
    this.contentPadding,
    this.hintDecoration,
    this.style,
    this.autovalidateMode,
    this.onFieldSubmitted,
    this.onSaved,
    this.textInputType,
  });
  final String? label;
  final String? hint;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Color? fillColor;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintDecoration;
  final TextStyle? style;
  final AutovalidateMode? autovalidateMode;
  final Function(String)? onFieldSubmitted;
  final Function(String? newValue)? onSaved;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ""),
        SizedBox(height: 5),
        TextFormField(
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: autovalidateMode,
          keyboardType: textInputType,
          decoration: InputDecoration(
            contentPadding:
                contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),

            fillColor: fillColor ?? context.colorScheme.tertiaryContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(color: context.colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide.none,
            ),
            hintText: hint,
            hintStyle: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
            errorStyle: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.w400,
            ),
          ),
          style: style,

          onSaved: onSaved,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
