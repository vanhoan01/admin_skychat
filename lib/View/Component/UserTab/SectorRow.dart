import 'package:admin_skychat/Model/Model/Chart/sector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectorRow extends StatelessWidget {
  const SectorRow(this.sector, {Key? key}) : super(key: key);
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: CircleAvatar(
            backgroundColor: sector.color,
          ),
        ),
        const Spacer(),
        Text(sector.title),
      ],
    );
  }
}
