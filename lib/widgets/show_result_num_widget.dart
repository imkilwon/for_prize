import 'package:flutter/material.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class ShowResultNumWidget extends StatefulWidget {
  final numberSet;
  final indexEx;
  const ShowResultNumWidget({Key? key,required this.numberSet,required this.indexEx}) : super(key: key);

  @override
  State<ShowResultNumWidget> createState() => _ShowResultNumWidgetState();
}

class _ShowResultNumWidgetState extends State<ShowResultNumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text("${widget.indexEx + 1}.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(width: 15,),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 14,
              );
            },
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, indexIn) {
              return Number(widget.numberSet[widget.indexEx][indexIn]);
            },
          ),
        ],
      ),
    );
  }
}
