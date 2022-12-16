import 'package:flutter/material.dart';

class FunctionGuideWidget extends StatelessWidget {
  final String functionName;
  final Widget page;

  const FunctionGuideWidget(
      {Key? key, required this.functionName, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 15,color: Colors.white,),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, bottom: 4),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  functionName,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 14.0),
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
