part of ruki_flutter_mentions;

enum SuggestionPosition { Top, Bottom }

class LengthMap {
  LengthMap({
    required this.start,
    required this.end,
    required this.str,
  });

  String str;
  int start;
  int end;
}

class Mention {
  Mention({
    required this.trigger,
    this.data,
    this.style,
    this.matchAll = false,
    this.suggestionBuilder,
    this.disableMarkup = false,
    this.markupBuilder,
    this.useAsync = false,
    this.onSelected,
    
    this.displayTarget = 'display',
    this.displayStyle = 'style',  
    this.displayId = 'id',
  });
  final Function(Map<String, dynamic>)? onSelected;
  final bool useAsync;

  final String displayTarget;
  final String displayStyle;
  final String displayId;
  /// A single character that will be used to trigger the suggestions.
  final String trigger;

  /// List of Map to represent the suggestions shown to the user
  ///
  /// You need to provide two properties `id` & `display` both are [String]
  /// You can also have any custom properties as you like to build custom suggestion
  /// widget.
  List<Map<String, dynamic>>? data;

  /// Style for the mention item in Input.
  final TextStyle? style;

  /// Should every non-suggestion with the trigger character be matched
  final bool matchAll;

  /// Should the markup generation be disabled for this Mention Item.
  final bool disableMarkup;

  /// Build Custom suggestion widget using this builder.
  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  /// Allows to set custom markup for the mentioned item.
  final String Function(String trigger, String mention, String value)?
      markupBuilder;

  void addAllToData(List<Map<String, dynamic>> data) {
    this.data = data;
  }

  @override
  String toString() {
    return 'Mention(trigger: $trigger, style: $style, matchAll: $matchAll, disableMarkup: $disableMarkup, useAsync: $useAsync, data: $data, suggestionBuilder: $suggestionBuilder, markupBuilder: $markupBuilder)';
  }
}

class Annotation {
  Annotation({
    required this.trigger,
    this.style,
    this.id,
    this.display,
    this.disableMarkup = false,
    this.markupBuilder,
  });

  TextStyle? style;
  String? id;
  String? display;
  String trigger;
  bool disableMarkup;
  final String Function(String trigger, String mention, String value)?
      markupBuilder;
}
