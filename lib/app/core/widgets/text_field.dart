import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/constants/constant.dart';
import '../../data/constants/extensions/text_style_extensions.dart';
import '../../data/constants/extensions/string_extensions.dart';
import '../../data/constants/extensions/boolean_extensions.dart';
import '../../data/constants/extensions/double_extension.dart';
import '../../data/constants/extensions/int_extensions.dart';
import '../../data/constants/extensions/decoration_extensions.dart';
import '../../data/constants/extensions/widget_extensions.dart';

enum TextFieldType {
  EMAIL,
  PASSWORD,
  NAME,
  ADDRESS,
  OTHER,
  PHONE,
  URL,
  USERNAME,
  IC,
  CONFIRM_PASSWORD,
}

/// Default Text Form Field
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType textFieldType;
  final String? title;
  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  final bool? isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String? obscuringCharacter;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final ToolbarOptions? toolbarOptions;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorMinimumPasswordLength;
  final String? errorInvalidURL;
  final String? errorInvalidUsername;
  final bool? autoValidate;

  final String? passwordOrigin;

  AppTextField({
    this.controller,
    required this.textFieldType,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions,
    this.autoFocus,
    this.readOnly,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorMinimumPasswordLength,
    this.errorInvalidURL,
    this.errorInvalidUsername,
    this.textAlignVertical,
    this.expands,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter,
    this.initialValue,
    this.keyboardAppearance,
    this.toolbarOptions,
    this.autoValidate,
    this.title,
    this.passwordOrigin,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPasswordVisible = false;

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired.validate(value: true)) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldType == TextFieldType.EMAIL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: '${widget.title ?? ''} is required');
          if (!s.trim().validateEmail())
            return widget.errorInvalidEmail.validate(value: 'Email is invalid');
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.PASSWORD) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(value: 'Please fill ${widget.title ?? ''}');
          }
          if (s.trim().length < ConstantValue.passwordLengthGlobal) {
            return widget.errorMinimumPasswordLength.validate(
                value: 'Password must have more than 8 characters');
          }
          // if (!isStrongPassword(s.trim())) {
          //   return '- Minimum 8 characters\n- At least 1 uppercase\n- At least 1 lowercase\n- At least 1 numerical\n- At least 1 symbol';
          // }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.CONFIRM_PASSWORD) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(value: 'Please fill ${widget.title ?? ''}');
          }
          if (s.trim().length < ConstantValue.passwordLengthGlobal) {
            return widget.errorMinimumPasswordLength.validate(
                value: 'Password must have more than 8 characters');
          }
          // if (!isStrongPassword(s.trim())) {
          //   return '- Minimum 8 characters\n- At least 1 uppercase\n- At least 1 lowercase\n- At least 1 numerical\n- At least 1 symbol';
          // }

          if (s.trim() != widget.passwordOrigin) {
            return 'Confirmation password not matched';
          }

          return null;
        };
      } else if (widget.textFieldType == TextFieldType.IC) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired
                .validate(value: 'Please fill ${widget.title ?? ''}');
          }
          if (s.trim().length < 12) {
            return widget.errorMinimumPasswordLength.validate(
                value:
                'Please fill valid NRIC without "-" (12 digits only)');
          }
          if (s.trim().length > 12) {
            return widget.errorMinimumPasswordLength.validate(
                value:
                'NRIC cannot be more than 12 characters');
          }

          if(s.trim().length == 12){
            if(!isValidIC(s.trim())){
              return 'Please fill in valid NRIC number';
            }
          }

          return null;
        };
      } else if (widget.textFieldType == TextFieldType.NAME ||
          widget.textFieldType == TextFieldType.PHONE ||
          widget.textFieldType == TextFieldType.OTHER) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: '${widget.title ?? ''} is required');
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.URL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: '${widget.title ?? ''} is required');
          if (!s.validateURL()) {
            return widget.errorInvalidURL.validate(value: 'Invalid URL');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.USERNAME) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: '${widget.title ?? ''} is required');
          if (s.contains(' ')) {
            return widget.errorInvalidUsername
                .validate(value: 'Username should not contain space');
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  bool isValidIC(String value) {
    return (value.substring(2, 4).toInt() <= 12) &&
        (value.substring(4, 6).toInt() <= 31) &&
        (value.substring(6, 8).toInt() <= 82);
  }


  bool isStrongPassword(String password) {
    // Define regular expressions for uppercase, lowercase, and numbers
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp symbolRegex = RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\-]');

    // Check if all conditions are met
    bool hasUppercase = uppercaseRegex.hasMatch(password);
    bool hasLowercase = lowercaseRegex.hasMatch(password);
    bool hasNumber = numberRegex.hasMatch(password);
    bool hasSymbol = symbolRegex.hasMatch(password);

    // Return true if all conditions are met
    return hasUppercase && hasLowercase && hasNumber && hasSymbol;
  }


  TextCapitalization applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization!;
    } else if (widget.textFieldType == TextFieldType.NAME) {
      return TextCapitalization.words;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldType == TextFieldType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputType.multiline;
    } else if (widget.textFieldType == TextFieldType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldType == TextFieldType.PHONE || widget.textFieldType == TextFieldType.IC) {
      return const TextInputType.numberWithOptions(signed: true);
    } else if (widget.textFieldType == TextFieldType.URL) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.textFieldType == TextFieldType.PASSWORD && !isPasswordVisible,
      validator: applyValidation(),
      autovalidateMode: widget.autoValidate != null
          ? (widget.autoValidate == false
              ? null
              : AutovalidateMode.onUserInteraction)
          : null,
      textCapitalization: applyTextCapitalization(),
      textInputAction: applyTextInputAction(),
      onFieldSubmitted: (s) {
        if (widget.nextFocus != null)
          FocusScope.of(context).requestFocus(widget.nextFocus);

        if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!.call(s);
      },
      keyboardType: applyTextInputType(),
      decoration: widget.decoration != null
          ? (widget.decoration!.copyWith(
              suffixIcon: widget.textFieldType == TextFieldType.PASSWORD
                  ? widget.suffix != null
                      ? widget.suffix
                      : Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.suffixIconColor ??
                              Theme.of(context).iconTheme.color,
                        ).onTap(() {
                          isPasswordVisible = !isPasswordVisible;

                          setState(() {});
                        })
                  : widget.suffix,
            ))
          : InputDecoration(),
      focusNode: widget.focus,
      style: widget.textStyle ??
          primaryTextStyle(size: ConstantValue.textPrimarySizeGlobal),
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.textFieldType == TextFieldType.ADDRESS
          ? null
          : widget.maxLines.validate(value: 1),
      minLines: widget.minLines.validate(value: 1),
      autofocus: widget.autoFocus ?? false,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ??
          Theme.of(context).textSelectionTheme.cursorColor,
      readOnly: widget.readOnly.validate(),
      maxLength: widget.maxLength,
      enableSuggestions: widget.enableSuggestions.validate(value: true),
      autofillHints: widget.autoFillHints,
      scrollPadding: widget.scrollPadding ?? EdgeInsets.all(20),
      cursorWidth: widget.cursorWidth.validate(value: 2.0),
      cursorHeight: widget.cursorHeight,
      cursorRadius: radiusCircular(4),
      onTap: widget.onTap,
      buildCounter: widget.buildCounter,
      scrollPhysics: BouncingScrollPhysics(),
      enableInteractiveSelection: true,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: widget.textAlignVertical,
      expands: widget.expands.validate(),
      showCursor: widget.showCursor,
      selectionControls: widget.selectionControls,
      strutStyle: widget.strutStyle,
      obscuringCharacter: widget.obscuringCharacter.validate(value: '•'),
      initialValue: widget.initialValue,
      keyboardAppearance: widget.keyboardAppearance,
      toolbarOptions: widget.toolbarOptions,
    );
  }
}
