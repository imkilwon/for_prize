
import 'package:flutter/material.dart';

Widget SimpleDialogWidget(String text,BuildContext context){

  Size screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        width: screenSize.width*0.7,
        height: screenSize.height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(child: Text(text,style: TextStyle(fontSize: 15),),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("확인")),
            ),
          ],
        ),
      ),
    ) ;
  }