import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class AutoSelectNumberLotteryScreen extends StatefulWidget {
  const AutoSelectNumberLotteryScreen({Key? key}) : super(key: key);

  @override
  State<AutoSelectNumberLotteryScreen> createState() => _AutoSelectNumberLotteryScreenState();
}

class _AutoSelectNumberLotteryScreenState extends State<AutoSelectNumberLotteryScreen> {
  int? selectedIndex;
  List<List<int>> resultSet = [];
  //ChoiceChip 선택할 수 있게 해주는 selectedIndex 선언
  List<bool> _isClicked = [];
  //생성된 값을 넣을 lottoSet
  List<int> numberSet = [];
  @override
  Widget build(BuildContext context) {

    //선택한 번호를 담을 numberSet
    List<int> lottoSet = [];
    List<int>tmp=[];
    for (int i = 0; i < 45; i++) {
      _isClicked.add(false);
      //전체에 다 클릭되지 않았다는 값을 넣고 시작
    }
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 14.0, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "숫자 선택하여\n자동으로 \n번호 추첨하기",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(numberSet.length<6){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.white,
                                  duration: Duration(seconds: 1),
                                  content: Text("숫자를 6개 이상 선택하셔야 합니다.",style: TextStyle(color: Colors.black),),
                                ),
                              );
                            }
                            else{
                              tmp.clear();
                              lottoSet.clear();
                              //여러 번 누를 수 있기 때문에 누를 때마다 clear할 수 있게 만듦
                              while (true) {
                                var rnd = Random().nextInt(numberSet.length);
                                //numberSet에 들어있는 숫자에 대응되는 인덱스를 사용하는 방식

                                if (!tmp.contains(rnd)) {
                                  //lottoSet에 랜덤 숫자가 없다? == 중복되지 않은 숫자
                                  lottoSet.add(numberSet[rnd]);
                                  tmp.add(rnd);
                                  //lottoSet에 넣음
                                }
                                if (tmp.length == 6) {
                                  lottoSet.sort();
                                  var result = lottoSet;
                                  resultSet.add(result);
                                  //lottoSet의 개수가 원하는 만큼 되면 정렬하고 탈출
                                  break;
                                }
                            }
                            }
                          });
                        },
                        child: Text("당첨 번호 추출")),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Wrap(
                //가로로 길게 나열한 위젯들이 기기의 해상도를 초과할 경우
                //다음 줄에 나타날 수 있께 해주는 Wrap위젯 이용
                children: [
                  for (int i = 0; i<45; i++)
                  //위젯을 여러 개 사용해야 하므로 for를 이용한다.
                    ChoiceChip(
                      //로또 번호를 선택할 수 있게 만들어주는 ChoiceChip 사용
                      label: Text("${i+1}"),
                      //해당 ChoiceChip에 번호를 나타내야하므로 적음
                      selected: _isClicked[i],
                      //selected가 true가 되면 ChoiceChip이 선택되고 false면 선택되지 않는다.
                      onSelected: (newBool){
                        //누르면 효과를 적어주기 위해 onSelected옵션
                        setState(
                              () {
                              //눌렀을 때 화면의 상태를 어떻게 변경시킬지에 대해 적을 setState
                              _isClicked[i] = !_isClicked[i];
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
                            }
                        );
                      },
                    ),
                  ShowNumberWidget(showText: "선택한 숫자 | ", numSet: numberSet),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: resultSet.length,
                      itemBuilder: (context, index_ex) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Text("${index_ex + 1}.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(width: 15,),
                              ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 14,
                                  );
                                },
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index_in) {
                                  return Number(resultSet[index_ex][index_in]);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),

            ],
          ),
        ),
      )
    );
  }
}
