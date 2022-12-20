import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class AutoSelectNumberLotteryScreen extends StatefulWidget {
  final List<int> numberSet;
  const AutoSelectNumberLotteryScreen({Key? key,required this.numberSet}) : super(key: key);

  @override
  State<AutoSelectNumberLotteryScreen> createState() => _AutoSelectNumberLotteryScreenState();
}

class _AutoSelectNumberLotteryScreenState extends State<AutoSelectNumberLotteryScreen> {
  int? selectedIndex;
  List<List<int>> resultSet = [];
  //ChoiceChip 선택할 수 있게 해주는 selectedIndex 선언
  //생성된 값을 넣을 lottoSet
  @override
  Widget build(BuildContext context) {

    //선택한 번호를 담을 numberSet
    List<int> lottoSet = [];
    List<int>tmp=[];

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
                      "선택한 숫자에서\n자동으로 \n번호 추첨하기",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                              tmp.clear();
                              lottoSet.clear();
                              //여러 번 누를 수 있기 때문에 누를 때마다 clear할 수 있게 만듦
                              while (true) {
                                var rnd = Random().nextInt(widget.numberSet.length);
                                //numberSet에 들어있는 숫자에 대응되는 인덱스를 사용하는 방식

                                if (!tmp.contains(rnd)) {
                                  //lottoSet에 랜덤 숫자가 없다? == 중복되지 않은 숫자
                                  lottoSet.add(widget.numberSet[rnd]);
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
        ),
      )
    );
  }
}
