part of ruki_flutter_mentions;

class AnnotatedText extends StatelessWidget {
  final String text;
  final RegExp? annotationsToIgnore;
  final Map<String, TextStyle> annotationStyles;
  final Map<String, Function(String annotatedText)>? annotationCallback;

  AnnotatedText({
    required this.text,
    required this.annotationStyles,
    this.annotationCallback,
    this.annotationsToIgnore,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildTextSpan(),
    );
  }

  TextSpan _buildTextSpan() {
    var spans = <TextSpan>[];
    var pattern = _generateRegExpPattern();
    var regex = RegExp(pattern);
    var remainingText = text;
    var completedText = '';
    Iterable<Match> matches = regex.allMatches(text);
    for (var match in matches) {
     
      var tempText = remainingText.substring(
          0, min(remainingText.length, match.start - completedText.length));

      spans.add(TextSpan(
        text: tempText,
        style: TextStyle(color: Colors.black),
        
      ));

      var annotatedText = match.group(0)!;
      completedText += '$tempText$annotatedText';

      spans.add(TextSpan(
        text: annotatedText,
        style: annotationStyles[annotatedText[0]] ??
            TextStyle(), // Apply style based on annotation prefix
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Handle click on annotated text
            if (annotationCallback != null) {
              annotationCallback![annotatedText]!(annotatedText);
            }
          },
      ));

      remainingText = text.substring(min(text.length, match.end));
    }

    if (remainingText.isNotEmpty) {
      spans.add(TextSpan(
        text: remainingText,
        style: TextStyle(color: Colors.black),
      ));
    } 
    return TextSpan(children: spans);
  }

  String _generateRegExpPattern() {
    var pattern = '((';
    for (var key in annotationStyles.keys) {
      pattern += key.replaceAllMapped(
             ( annotationsToIgnore ?? RegExp(r'[.?*+^$[\]\\(){}|]-')), (m) => '\\\\\$"${m[0]}"') +
          '|';
    }

    pattern = pattern.substring(0, pattern.length - 1) + ')(\\w+))';

    return pattern;
  }
}
