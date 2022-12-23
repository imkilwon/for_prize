import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:for_prize/main.dart';
import 'package:for_prize/screens/auto_lottery_about_check_screen.dart';
import 'package:for_prize/screens/auto_select_num_lottery_about_check_screen.dart';
import 'package:for_prize/screens/semi_auto_lottery_about_check_screen.dart';
import 'package:for_prize/screens/semi_auto_select_num_about_check_screen.dart';
import 'package:for_prize/utils/utils.dart';

class CheckBySectionScreen extends StatefulWidget {
  final int pageNum;

  //pageNum == 1 -> 구간 선택만 / 2 -> 숫자 선택 후 구간 선택까지
  final selectNum;

  //모든 숫자에서 구간별 개수 선택하여 추출 스크린
  const CheckBySectionScreen({Key? key, required this.pageNum, this.selectNum})
      : super(key: key);

  @override
  State<CheckBySectionScreen> createState() => _CheckBySectionScreenState();
}

class _CheckBySectionScreenState extends State<CheckBySectionScreen> {

  List<int> resultCnt = [0,0,0,0,0];
  List<int> holdNumber = [];
  List<String> sectionName = ["1~10", "11~20", "21~30", "31~40", "41~45"];
  List<List<int>> sectionCnt = [
    [0, 1, 2, 3, 4, 5, 6],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 1, 2, 3, 4, 5, 6]
  ];
  bool isVisible = false;
  List<List<bool>> isChecked = [
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
  ];
  List<int> result = [0, 0, 0, 0, 0];
  bool breakPoint = true;
  CountResultNum(List<int> selectNum){
    for (int i = 0; i<selectNum.length; i++){
      if (0 < selectNum[i] && selectNum[i]<=10){
        resultCnt[0]++;
      }else if(11 < selectNum[i] && selectNum[i] <= 20){
        resultCnt[1]++;
      }else if(21 < selectNum[i] && selectNum[i] <= 30){
        resultCnt[2]++;
      }else if(31 < selectNum[i] && selectNum[i] <= 40){
        resultCnt[3]++;
      }else if(41 < selectNum[i] && selectNum[i] <= 45){
        resultCnt[4]++;
      }
    }
  }


  @override
  void initState() {
    super.initState();
    holdNumber = Utils().readStringListData("Hold Number");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 14.0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "구간 별 \n개수 선택 화면",
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
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
                child: Text(
              "좌우로 드래그하시면 체크 박스가 더 있습니다.",
              style: TextStyle(fontSize: 15, color: Colors.white70),
            )),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, indexEx) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                    ),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 65,
                            child: Text(
                              sectionName[indexEx],
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 1,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indexIn) {
                                return Column(
                                  children: [
                                    Text(
                                      (indexIn).toString(),
                                      style: TextStyle(color: Colors.blue[800]),
                                    ),
                                    Checkbox(
                                      activeColor: Colors.greenAccent,
                                      value: isChecked[indexEx][indexIn],
                                      onChanged: (bool? value) {
                                        setState(
                                          () {
                                            //현재 클릭한 것 제외하고는 모두 체크가 될 수 없게 하는 코드
                                            isChecked[indexEx] =
                                                isChecked[indexEx]
                                                    .map((e) => false)
                                                    .toList();
                                            //누른 값이 체크 되게 함
                                            isChecked[indexEx][indexIn] =
                                                value!;
                                            result[indexEx] = isChecked[indexEx]
                                                .indexOf(true);
                                            //모든 구간을 체크했으면, 숨겨진 Floating Button 보이게
                                            if (isChecked[0].contains(true) &&
                                                isChecked[1].contains(true) &&
                                                isChecked[2].contains(true) &&
                                                isChecked[3].contains(true) &&
                                                isChecked[4].contains(true)) {
                                              isVisible = true;
                                            }
                                            //모든 구간이 체크되지 않았다면 보이지 않게
                                            else {
                                              isVisible = false;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              if(widget.selectNum != null){
                CountResultNum(widget.selectNum);
                for(int i = 0; i<5; i++){
                  if(resultCnt[i] < result[i]){
                    //선택한 숫자 목록에서 구간별 개수가 선택한 구간 개수보다 적으면 다시 시도하게 하는 코드
                    breakPoint = false;
                  }
                }
              }
              else{
                breakPoint = true;
              }



              if(breakPoint){
                if (widget.pageNum == 3 || widget.pageNum == 4) {
                  // 반자동일때
                  var sum = result.sum + holdNumber.length;
                  if (sum != 6) {
                    Utils().showSnackBar(
                        context: context, content: "모든 구간의 개수 합이 6이 되어야 합니다.");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget.pageNum == 3
                                ? SemiAutoLotteryAboutCheckScreen(
                                    result: result,
                                    holdNumber: holdNumber,
                                  )
                                : SemiAutoSelectNumAboutCheckScreen(
                                    result: result,
                                    selectNum: widget.selectNum,
                                    holdNumber: holdNumber,
                                  )));
                  }
                } else {
                  if (result.sum != 6) {
                    Utils().showSnackBar(
                        context: context, content: "모든 구간의 개수 합이 6이 되어야 합니다.");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.pageNum == 1
                            ? AutoLotteryAboutCheckScreen(result: result)
                            : AutoSelectNumLotteryAboutCheckScreen(
                                result: result,
                                selectNum: widget.selectNum,
                              ),
                      ),
                    );
                  }
                }
              }else{
                Utils().showSnackBar(context: context, content: "선택하신 숫자가 구간 개수보다 적습니다.");
              }
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
