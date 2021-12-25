part of bank_components;

class MainTextField extends StatefulWidget {
  final TextfieldType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextAlign textAlign;
  final String label;
  final TextfieldHelper helper;
  final int limit;
  final TextfieldExtend prefix;
  final TextfieldExtend suffix;
  final Function(String) validator;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;
  MainTextField(
      {@required this.controller,
      this.textAlign,
      this.label,
      this.helper,
      this.limit,
      this.prefix,
      this.suffix,
      this.validator,
      @required this.type,
      this.keyboardType,
      this.onChanged,
      this.inputFormatters,
      this.focusNode});

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign:
              widget.textAlign != null ? widget.textAlign : TextAlign.start,
          maxLength: widget.limit,
          buildCounter: (context, {currentLength, isFocused, maxLength}) {
            return Container(
              child: Text(
                widget.limit != null
                    ? replaceFarsiNumber(
                        '$maxLength/${widget.controller.text.length}')
                    : '',
                style: Theme.of(context).inputDecorationTheme.counterStyle,
              ),
            );
          },
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            labelText: widget.label,
            helperText: widget.helper != null ? '' : null,
            prefixIcon: _buildExtendWidget(widget.prefix, context, false),
            suffixIcon: widget.type == TextfieldType.Password
                ? _buildEyeIconSuffix()
                : _buildExtendWidget(widget.suffix, context, true),
            contentPadding: EdgeInsets.all(12),
          ),
          obscureText: showPassword ? false : true,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
        ),
        widget.helper != null
            ? Positioned(
                bottom: 0,
                right: 12,
                child: _buildTextFieldHelperWidget(context),
              )
            : SizedBox(),
      ],
    );
  }

  _buildTextFieldHelperWidget(BuildContext context) {
    if (widget.helper.type == HeplerType.Regular) {
      // regular
      return Text(
        widget.helper.text,
        style: Theme.of(context).inputDecorationTheme.helperStyle,
      );
    } else {
      // success or error
      return Row(
        children: [
          // TODO: change icon data with real one
          Icon(
            widget.helper.type == HeplerType.Success ? Icons.info : Icons.info,
            color: widget.helper.type == HeplerType.Success
                ? widget.helper.theme.success
                : widget.helper.theme.error,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              widget.helper.text,
              style: Theme.of(context)
                  .inputDecorationTheme
                  .helperStyle
                  .copyWith(
                      color: widget.helper.type == HeplerType.Success
                          ? widget.helper.theme.success
                          : widget.helper.theme.error),
            ),
          ),
        ],
      );
    }
  }

  _buildEyeIconSuffix() {
    return InkWell(
      onTap: () {
        setState(() {
          showPassword = !showPassword;
        });
      },
      child: Icon(showPassword
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined),
    );
  }

  _buildExtendWidget(
      TextfieldExtend widget, BuildContext context, bool isSuffix) {
    if (widget == null) {
      return null;
    } else if (widget.type == TextfieldExtendType.Icon) {
      // icon

      return InkWell(
        onTap: widget.onTap,
        child: Icon(
          widget.icon.icon,
          color: widget.icon.iconColor,
        ),
      );
    } else if (widget.type == TextfieldExtendType.Text) {
      // text

      return Padding(
        padding:
            EdgeInsets.only(left: isSuffix ? 4 : 8, right: !isSuffix ? 4 : 8),
        child: Container(
          height: 40,
          width: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: widget.textBackgroundColor,
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      );
    } else {
      // child
      return widget.child;
    }
  }
}

class TextfieldHelper {
  final HeplerType type;
  final String text;
  final HelperWidgetTheme theme;

  TextfieldHelper(
      {@required this.type, @required this.text, @required this.theme});
}

class HelperWidgetTheme {
  // on regular type you don't need to pass this
  final Color success;
  final Color error;

  HelperWidgetTheme({@required this.success, @required this.error});
}

class TextfieldExtend {
  final TextfieldExtendType type;
  final CustomIconTheme icon;
  final String text;
  final Widget child;
  final Function onTap;
  final Color textBackgroundColor;

  TextfieldExtend({
    @required this.type,
    this.icon,
    this.text,
    this.child,
    this.onTap,
    this.textBackgroundColor,
  });
}

enum HeplerType { Regular, Error, Success }

enum TextfieldExtendType { Icon, Text, Child }

enum TextfieldType { Reqular, Password }

class CodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var numberIndex = oldValue.text.lastIndexOf(RegExp(r'@"^\d$"'));

    if (newValue.text.length > oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text.replaceFirst(RegExp(r'- |-'), ''),
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    } else {
      return TextEditingValue(
        text: newValue.text + '- ',
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    }
  }
}