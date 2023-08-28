part of bank_components;

class AmountTextField extends StatefulWidget {
  final TextStyle textFieldStyle;
  final TextStyle textUnitStyle;
  final Function(String) onTextFieldChanged;
  final dynamic Function(String) validator;
  final String currency;

  final GlobalKey<FormState> formKey;

  AmountTextField({
    @required this.textFieldStyle,
    @required this.textUnitStyle,
    @required this.currency,
    this.onTextFieldChanged,
    this.validator,
    this.formKey,
  });

  @override
  _AmountTextFieldState createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  TextEditingController controller;
  var wordPrice = '';

  @override
  void initState() {
    var regExp = "\B${widget.currency}";
    controller = RichTextController(
      patternMatchMap: {
        RegExp(regExp): widget.textUnitStyle,
      },
      onMatch: (List<String> match) {},
      deleteOnBack: true,
      text: widget.currency,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      controller: controller,
      inputFormatters: [PriceTextFormatter(currency: widget.currency)],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      type: TextfieldType.Reqular,
      onChanged: (value) {
        var result =
            replaceToEnglishNumber(value).replaceAll(RegExp('[^0-9]'), '');

        // final regexp = RegExp(r'(?:ریال\u2067)|(?:ریال)');
        final regexp =
            RegExp('(?:${widget.currency}\u2067)|(?:${widget.currency})');
        if (widget.formKey != null) {
          if (!widget.formKey.currentState.validate()) {
            wordPrice = null;
          } else {
            wordPrice = result.replaceAll(regexp, '');
          }
        } else {
          wordPrice = result.replaceAll(regexp, '');
        }

        setState(() {});

        widget.onTextFieldChanged(result);
      },
      validator: widget.validator,
      helper: wordPrice == null || wordPrice.isEmpty
          ? SizedBox()
          : Text(
              wordPrice.toWord() + widget.currency,
              style: Theme.of(context).textTheme.caption,
            ),
      textDirection: TextDirection.ltr,
      textFieldStyle: widget.textFieldStyle,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class PriceTextFormatter extends TextInputFormatter {
  final String currency;
  PriceTextFormatter({@required this.currency});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final currencySymbol = currency + '\u2067';
    if (newValue.text.isEmpty ||
        newValue.text.trim() == currencySymbol.trim()) {
      return newValue.copyWith(text: '$currencySymbol');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      var newString = replaceToEnglishNumber(newValue.text)
          .replaceAll(RegExp('[^0-9]'), '');
      if (newString.trim().isEmpty) {
        return TextEditingValue(
          text: currencySymbol,
          selection: TextSelection.fromPosition(
              TextPosition(offset: currencySymbol.length)),
        );
      } else {
        final f = intel.NumberFormat("#,###");
        var num = int.parse(replaceToEnglishNumber(newValue.text)
            .replaceAll(RegExp('[^0-9]'), ''));
        final newString = '$currencySymbol' + '\u2066' + f.format(num).trim();

        return TextEditingValue(
          text: replaceToFarsiNumber(newString),
          selection: TextSelection.fromPosition(
              TextPosition(offset: newString.length)),
        );
      }
    } else {
      return newValue;
    }
  }
}
