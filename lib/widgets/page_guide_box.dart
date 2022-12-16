import 'package:flutter/material.dart';

class PageGuideBox extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Widget page;
  const PageGuideBox({Key? key,required this.width,required this.height,required this.text,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> page));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10,10,10,0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
