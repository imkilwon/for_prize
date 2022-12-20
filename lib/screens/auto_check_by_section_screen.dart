import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:for_prize/main.dart';
import 'package:for_prize/screens/auto_all_number_lottery_about_check_screen.dart';
import 'package:for_prize/utils/utils.dart';

class AutoAllNumberBySectionScreen extends StatefulWidget {
  //모든 숫자에서 구간별 개수 선택하여 추출 스크린
  const AutoAllNumberBySectionScreen({Key? key}) : super(key: key);

  @override
  State<AutoAllNumberBySectionScreen> createState() =>
      _AutoAllNumberBySectionScreenState();
}

class _AutoAllNumberBySectionScreenState
    extends State<AutoAllNumberBySectionScreen> {
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
  List<int> result = [0,0,0,0,0];

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
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
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
                itemBuilder: (context, index_ex) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                    ),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 65,
                            child: Text(
                              sectionName[index_ex],
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 1,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index_in) {
                                return Column(
                                  children: [
                                    Text(
                                      (index_in).toString(),
                                      style: TextStyle(color: Colors.blue[800]),
                                    ),
                                    Checkbox(
                                      activeColor: Colors.greenAccent,
                                      value: isChecked[index_ex][index_in],
                                      onChanged: (bool? value) {
                                        setState(
                                          () {
                                            //현재 클릭한 것 제외하고는 모두 체크가 될 수 없게 하는 코드
                                            isChecked[index_ex] = isChecked[index_ex].map((e)=>false).toList();
                                            //누른 값이 체크 되게 함
                                            isChecked[index_ex][index_in] =
                                                value!;
                                            result[index_ex] = isChecked[index_ex].indexOf(true);
                                            //모든 구간을 체크했으면, 숨겨진 Floating Button 보이게
                                            if(isChecked[0].contains(true) &&isChecked[1].contains(true) &&isChecked[2].contains(true) &&isChecked[3].contains(true) &&isChecked[4].contains(true)){
                                              isVisible = true;
                                            }
                                            //모든 구간이 체크되지 않았다면 보이지 않게
                                            else{
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
          onPressed: (){

            setState(() {
              if(result.sum >6 || result.sum <6){
                Utils().showSnackBar(context: context, content: "모든 구간의 개수 합이 6이 되어야 합니다.");
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AutoAllNumberLotteryAboutCheckScreen(result: result)));
              }

            });


          },
          child: Icon(Icons.arrow_forward,size: 40,),
        ),
      ),
    );
  }
}
