import 'package:flutter/material.dart';

class ShowNumberWidget extends StatelessWidget {
  final String showText;
  final List<int> numSet;
  const ShowNumberWidget({Key? key,required this.showText,required this.numSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top:10),
        width: screenSize.width*0.95,
        height: screenSize.height *0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Text("${showText}",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            Number(numSet[0]),
            Number(numSet[1]),
            Number(numSet[2]),
            Number(numSet[3]),
            Number(numSet[4]),
            Number(numSet[5]),
          ],
        ),
      ),
    );
  }
}
Widget Number(int num){
  if(0<(num)&&(num) <= 10){
    return Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,width: 27,height: 27,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.yellow,),child: Text(num.toString()),);
  }else if(10<(num)&&(num)<=20){
    return Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,width: 27,height: 27,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.blue,),child: Text(num.toString()),);
  }else if(20<(num)&&(num) <= 30){
    return Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,width: 27,height: 27,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red,),child: Text(num.toString()),);
  }else if(30<(num)&&(num)<=40){
    return Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,width: 27,height: 27,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.grey,),child: Text(num.toString()),);
  }else if(40<(num)&&(num)<=45){
    return Container(margin: EdgeInsets.only(left: 10),alignment: Alignment.center,width: 27,height: 27,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent,),child: Text(num.toString()),);
  }else{
    return Text("");
  }

}