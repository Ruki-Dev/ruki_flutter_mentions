part of flutter_mentions;

class OptionListController{
  Function(List<Map<String, dynamic>>) updateData = (List<Map<String, dynamic>> data) => {};
}
class OptionList extends StatefulWidget {
  OptionList({
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
    this.controller,
    this.forceListHeight = false,
    this.padding = EdgeInsets.zero,
  });
  final bool forceListHeight;

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final EdgeInsetsGeometry padding;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  final OptionListController? controller;

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  OptionListController? controller;
  
  @override
  void initState() {
    controller = widget.controller ?? OptionListController();
    super.initState();
    controller!.updateData = (List<Map<String, dynamic>> data) {
      if(mounted) {
        setState(() {
        widget.data.clear();
        widget.data.addAll(data);
      });
      }
    };
  }
  @override
  Widget build(BuildContext context) {
    return widget.data.isNotEmpty
        ? Container(
          padding: widget.padding,
            decoration:
                widget.suggestionListDecoration ?? BoxDecoration(color: Colors.white),
                height: widget.forceListHeight ? widget.suggestionListHeight : null,
            constraints: widget.forceListHeight ? null : BoxConstraints(
              maxHeight: widget.suggestionListHeight,
              minHeight: 0,
            ),
            child: ListView.builder(
              itemCount: widget.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onTap(widget.data[index]);
                  },
                  child: widget.suggestionBuilder != null
                      ? widget.suggestionBuilder!(widget.data[index])
                      : Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            widget.data[index]['display'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                );
              },
            ),
          )
        : Container();
  }
}
