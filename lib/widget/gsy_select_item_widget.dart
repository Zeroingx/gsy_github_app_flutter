import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';

/// 详情issue列表头部，PreferredSizeWidget
/// Created by guoshuyu
/// Date: 2018-07-19

typedef SelectItemChanged<int> = void Function(int value);

class GSYSelectItemWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final List<String> itemNames;

  final SelectItemChanged? selectItemChanged;

  final RoundedRectangleBorder? shape;

  final double elevation;

  final double height;

  final EdgeInsets margin;

  const GSYSelectItemWidget(
    this.itemNames,
    this.selectItemChanged, {super.key, 
    this.elevation = 5.0,
    this.height = 70.0,
    this.shape,
    this.margin = const EdgeInsets.all(10.0),
  });

  @override
  _GSYSelectItemWidgetState createState() => _GSYSelectItemWidgetState();

  @override
  Size get preferredSize {
    return Size.fromHeight(height);
  }
}

class _GSYSelectItemWidgetState extends State<GSYSelectItemWidget> {
  int selectIndex = 0;
  int preSelIndex = 0;
  List keys = [false,false];

  _GSYSelectItemWidgetState();


  @override
  void initState() {
    super.initState();
    keys = widget.itemNames.map((e) => false).toList();
  }

  _renderItem(String name, int index) {
    var style = index == selectIndex
        ? GSYConstant.middleTextWhite
        : GSYConstant.middleSubLightText;
    if(preSelIndex!=index && index == selectIndex){
      //说明此项是变项,key值取反
      keys[index] = !keys[index];
    }
    return Expanded(
      child: AnimatedSwitcher(
        transitionBuilder: (child, anim) {
          return ScaleTransition(scale: anim, child: child);
        },
        duration: const Duration(milliseconds: 300),
        child: RawMaterialButton(
            key: ValueKey(keys[index]),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style: style,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              if (selectIndex != index) {
                widget.selectItemChanged?.call(index);
              }
              setState(() {
                preSelIndex = selectIndex;
                selectIndex = index;
              });
            }),
      ),
    );
  }

  _renderList() {
    List<Widget> list = [];
    for (int i = 0; i < widget.itemNames.length; i++) {
      if (i == widget.itemNames.length - 1) {
        list.add(_renderItem(widget.itemNames[i], i));
      } else {
        list.add(_renderItem(widget.itemNames[i], i));
        list.add(Container(
            width: 1.0, height: 25.0, color: GSYColors.subLightTextColor));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GSYCardItem(
        elevation: widget.elevation,
        margin: widget.margin,
        color: Theme.of(context).primaryColor,
        shape: widget.shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
        child: Row(
          children: _renderList(),
        ));
  }
}
