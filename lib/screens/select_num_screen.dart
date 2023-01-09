import 'package:flutter/material.dart';
import 'package:for_prize/screens/check_by_section_screen.dart';
import 'package:for_prize/screens/auto_select_number_lottery_screen.dart';
import 'package:for_prize/screens/semi_auto_select_num_about_check_screen.dart';
import 'package:for_prize/screens/semi_auto_select_number_lottery_screen.dart';

import '../utils/utils.dart';
import '../widgets/show_number_widget.dart';

class SelectNumScreen extends StatefulWidget {
  final holdLength;
  final pageNum;

  //1== 자동 전체, 2== 자동 범위,3== 반자동 전체, 4== 반자동 범위
  const SelectNumScreen({Key? key, this.holdLength = 0, required this.pageNum})
      : super(key: key);

  @override
  State<SelectNumScreen> createState() => _SelectNumScreenState();
}

class _SelectNumScreenState extends State<SelectNumScreen> {
  List<int> holdNumber =[];
  bool isVisible = false;
  List<List<int>> resultSet = [];

  //ChoiceChip 선택할 수 있게 해주는 selectedIndex 선언
  List<bool> isClicked = [];

  //생성된 값을 넣을 lottoSet
  List<int> numberSet = [];

  @override
  void initState(){
    super.initState();
    holdNumber = Utils().readStringListData("Hold Number");
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 45; i++) {
      isClicked.add(false);
      //전체에 다 클릭되지 않았다는 값을 넣고 시작
    }
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 14.0, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "숫자 \n선택하기",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Wrap(
              //가로로 길게 나열한 위젯들이 기기의 해상도를 초과할 경우
              //다음 줄에 나타날 수 있께 해주는 Wrap위젯 이용
              children: [
                for (int i = 0; i < 45; i++)
                  //위젯을 여러 개 사용해야 하므로 for를 이용한다.
                  ChoiceChip(
                    selectedColor: Colors.yellowAccent,
                    //로또 번호를 선택할 수 있게 만들어주는 ChoiceChip 사용
                    label: Text("${i + 1}"),
                    //해당 ChoiceChip에 번호를 나타내야하므로 적음
                    selected: isClicked[i],
                    //selected가 true가 되면 ChoiceChip이 선택되고 false면 선택되지 않는다.
                    onSelected: (newBool) {
                      //누르면 효과를 적어주기 위해 onSelected옵션
                      setState(() {

                        //고정된 번호가 있는 pageNum 3,4에서는 고정된 번호를 선택할 때, 메세지로 알려주어야 함.
                        if((widget.pageNum == 3)||(widget.pageNum ==4)){
                          if(holdNumber.contains(i+1)){
                            Utils().showSnackBar(context: context, content: "고정하신 숫자를 선택하실 수 없습니다.");
                            return;
                          }
                        }
                        //눌렀을 때 화면의 상태를 어떻게 변경시킬지에 대해 적을 setState
                        isClicked[i] = !isClicked[i];
                        //selectedIndex에 i를 넣어서 해당 번호가 selected에서 true가 되게 만든다.
                        //이러면 20을 누르면 selected에 20이 들어가고 색칠된 상태로 표시된다.
                        //이후 5를 누르면 selected에 5가 들어가고 20의 색칠이 지워지고 5에 색칠이 된다.
                        if (!(numberSet.contains(i + 1))) {
                          //만약 누른 번호가 numberSet에 없다면?
                          numberSet.add(i + 1);
                          numberSet.sort();
                          //numberSet에 해당 번호를 누른다.
                        } else {
                          numberSet.remove(i + 1);
                          numberSet.sort();
                        }

                        if (numberSet.length + widget.holdLength >= 6) {
                          isVisible = true;
                        } else {
                          isVisible = false;
                        }
                      });
                    },
                  ),
                ShowNumberWidget(showText: "선택한 숫자 | ", numSet: numberSet),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.pageNum == 1 ?
                    AutoSelectNumberLotteryScreen(numberSet: numberSet)
                        : widget.pageNum== 2 ?
                    CheckBySectionScreen(pageNum: 2,selectNum: numberSet,)
                        : widget.pageNum == 3 ?
                    SemiAutoSelectNumberLotteryScreen(numberSet: numberSet)
                            : CheckBySectionScreen(pageNum: 4,selectNum: numberSet,),
                  ));
            });
          },
          child: const Icon(
            Icons.arrow_forward,
            size: 40,
          ),
        ),
      ),
    );
  }
}
