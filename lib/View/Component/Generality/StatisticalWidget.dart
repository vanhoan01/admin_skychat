import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StatisticalWidget extends StatefulWidget {
  const StatisticalWidget({
    super.key,
    required this.select,
    required this.title,
    required this.currently,
    required this.before,
  });
  final bool select;
  final String title;
  final int currently;
  final int before;

  @override
  State<StatisticalWidget> createState() => _StatisticalWidgetState();
}

class _StatisticalWidgetState extends State<StatisticalWidget> {
  String change() {
    String rs = "";
    int dif = widget.currently - widget.before;
    if (dif > 0) {
      rs = "+$dif";
    } else {
      rs = "$dif";
    }
    return rs;
  }

  String percent() {
    String rs = "";

    if (widget.before == 0) {
      rs = "--";
    } else {
      double dif = double.parse(
          (widget.currently * 1.0 / widget.before - 1).toStringAsFixed(2));
      if (dif > 0) {
        rs = "+${dif * 100}%";
      } else {
        rs = "${dif * 100}%";
      }
    }
    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.select ? Colors.blue : Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: widget.select ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            "${widget.currently}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.select ? Colors.white : Colors.black),
          ),
          Text(
            "${change()} (${percent()})",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.select ? Colors.white : Colors.blue),
          ),
        ],
      ),
    );
  }
}
