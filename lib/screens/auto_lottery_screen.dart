import 'package:flutter/material.dart';
import 'package:for_prize/main.dart';
import 'package:for_prize/screens/auto_all_number_lottery_screen.dart';
import 'package:for_prize/widgets/function_guide_widget.dart';

class AutoLotteryScreen extends StatelessWidget {
  const AutoLotteryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:20,left:14.0,bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("자동으로 \n번호 추첨하기",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close)),
                ],
              ),
            ),
            SizedBox(height: 50,),
            FunctionGuideWidget(functionName: "전체 숫자 중 추첨", page: AutoAllNumberLotteryScreen()),
            FunctionGuideWidget(functionName: "선택한 숫자 중 추첨", page: ForPrize()),
            FunctionGuideWidget(functionName: "각 구간별 개수 선택 후 추첨", page: ForPrize()),
            FunctionGuideWidget(functionName: "숫자 선택 후 구간별 개수 추첨", page: ForPrize()),
            Divider(height: 15,color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
