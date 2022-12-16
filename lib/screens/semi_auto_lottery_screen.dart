import 'package:flutter/material.dart';
import 'package:for_prize/main.dart';
import 'package:for_prize/screens/hold_number_page.dart';
import 'package:for_prize/widgets/function_guide_widget.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class SemiAutoLotteryScreen extends StatelessWidget {
  const SemiAutoLotteryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 14.0, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "반자동으로 \n번호 추첨하기",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                Container(width: double.infinity,height: 100,color: Colors.white70,),
                Positioned(top:10,child: Container(
                  width: screenSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("현재 고정하신 숫자"),
                      GestureDetector(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const HoldNumberPage())); },child: const Text("숫자 고정 하기 >")),
                    ],
                  ),
                )),
                Positioned.fill(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 3,itemBuilder: (context,index)=>Text('1')))
              ],
            ),
            SizedBox(
              height: 25,
            ),
            FunctionGuideWidget(functionName: "전체 숫자 중 추첨", page: ForPrize()),
            FunctionGuideWidget(functionName: "선택한 숫자 중 추첨", page: ForPrize()),
            FunctionGuideWidget(
                functionName: "각 구간별 개수 선택 후 추첨", page: ForPrize()),
            FunctionGuideWidget(
                functionName: "숫자 선택 후 구간별 개수 추첨", page: ForPrize()),
            Divider(
              height: 15,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
