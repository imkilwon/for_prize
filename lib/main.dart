import 'package:flutter/material.dart';
import 'package:for_prize/screens/auto_lottery_screen.dart';
import 'package:for_prize/screens/hold_number_page.dart';
import 'package:for_prize/screens/semi_auto_lottery_screen.dart';
import 'package:for_prize/widgets/page_guide_box.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: ForPrize(),
    ),
  );
}

class ForPrize extends StatelessWidget {
  ForPrize({Key? key}) : super(key: key);
  List<int> dates = [DateTime.now().year,DateTime.now().month,DateTime.now().day];

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
              padding: const EdgeInsets.only(left:14.0,bottom: 4),
              child: Text("ForPrize!",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
            Row(
              children: [
                SizedBox(width: 14,),
                Text("${dates[0].toString()} / ${dates[1].toString()} / ${dates[2].toString()}",style: TextStyle(fontSize: 17,color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold),),
                ],
            ),
            ShowNumberWidget(showText: "전 주의 추천 번호",numSet: [12,16,43,32,33,6],),
            ShowNumberWidget(showText: "전 주의 당첨 번호",numSet: [12,16,43,32,33,6],),
            Row(
              children: [
                PageGuideBox(width: (screenSize.width-40)/2, height:screenSize.height*0.3,text: "추천 번호 \n받으러 가기",page: AutoLotteryScreen()),
                Column(
                  children: [
                    PageGuideBox(width:(screenSize.width-40)/2, height: (screenSize.height)*0.3/2 - 5,text: "자동 추첨 하기",page: AutoLotteryScreen(),),
                    PageGuideBox(width:(screenSize.width-40)/2, height: (screenSize.height)*0.3/2 - 5,text: "반자동 추첨 하기",page: SemiAutoLotteryScreen()),
                  ],
                ),
              ],
            ),
            PageGuideBox(width: (screenSize.width)*0.95, height: screenSize.height*0.14, text: "내가 저장한 번호 보러가기",page: AutoLotteryScreen()),
            PageGuideBox(width: (screenSize.width)*0.95, height: screenSize.height*0.14, text: "이벤트 • 공지사항",page: AutoLotteryScreen()),
          ],
        ),
      )
    );
  }
}
