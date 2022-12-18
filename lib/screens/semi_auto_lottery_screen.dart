import 'package:flutter/material.dart';
import 'package:for_prize/main.dart';
import 'package:for_prize/screens/hold_number_page.dart';
import 'package:for_prize/screens/semi_auto_all_number_lottery_screen.dart';
import 'package:for_prize/screens/semi_auto_select_number_lottery_screen.dart';
import 'package:for_prize/utils/utils.dart';
import 'package:for_prize/widgets/function_guide_widget.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class SemiAutoLotteryScreen extends StatefulWidget {
  SemiAutoLotteryScreen({Key? key}) : super(key: key);

  @override
  State<SemiAutoLotteryScreen> createState() => _SemiAutoLotteryScreenState();
}

class _SemiAutoLotteryScreenState extends State<SemiAutoLotteryScreen> {
  List<int> holdNumber=[];

  @override
  void initState(){
    holdNumber = Utils().readStringListData("Hold Number");
  }

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
            Container(width: double.infinity,alignment: AlignmentDirectional.bottomEnd,margin: EdgeInsets.only(right: 20),child: GestureDetector(onTap: ()async{
             NavigateToHoldNumberPage(context);
            },child: Text("숫자 고정 Page ➤",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white70),))),
            ShowNumberWidget(showText: "고정하신 숫자", numSet: holdNumber ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("고정하신 숫자를 제외하고 남은 숫자들을",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
            const FunctionGuideWidget(functionName: "전체 숫자 중 추첨", page: SemiAutoAllNumberLotteryScreen()),
            const FunctionGuideWidget(functionName: "선택한 숫자 중 추첨", page:SemiAutoSelectNumberLotteryScreen()),
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

  Future<void> NavigateToHoldNumberPage(BuildContext context) async {

    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>HoldNumberPage()));
    if (!mounted) return;
    setState(() {
      holdNumber = result;
    });
  }
}
