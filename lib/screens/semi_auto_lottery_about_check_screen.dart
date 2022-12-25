import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_prize/utils/utils.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class SemiAutoLotteryAboutCheckScreen extends StatefulWidget {
  List<int> result;
  List<int> holdNumber;
  SemiAutoLotteryAboutCheckScreen({Key? key,required this.result,required this.holdNumber}) : super(key: key);

  @override
  State<SemiAutoLotteryAboutCheckScreen> createState() => _SemiAutoLotteryAboutCheckScreenState();
}

class _SemiAutoLotteryAboutCheckScreenState extends State<SemiAutoLotteryAboutCheckScreen> {
  List<List<int>> sectionNum = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9,10],
    [11, 12, 13, 14, 15, 16, 17, 18, 19,20],
    [21, 22, 23, 24, 25, 26, 27, 28, 29,30],
    [31, 32, 33, 34, 35, 36, 37, 38, 39,40],
    [41, 42, 43, 44, 45,0,0,0,0,0]
  ];

  List<List<int>> numberSet = [];
  @override
  Widget build(BuildContext context) {
    List<int> tmp = [];
    int cnt = 0;

    return Scaffold(
        backgroundColor: Colors.blue[800],
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight+500),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 14.0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "고정된 번호에서\n구간별로 정한 숫자만큼\n번호 추출하기",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tmp.clear();
                        tmp.addAll(widget.holdNumber);
                        for(int i = 0; i<widget.result.length; i++){
                          cnt = 0;
                          while(true){
                            var rnd = Random().nextInt(10);
                            //0~9까지 중 인덱스를 랜덤하게 출력
                            if(cnt == widget.result[i]){
                              break;
                            }
                            if((!(tmp.contains(sectionNum[i][rnd])))&&(sectionNum[i][rnd]!=0)){
                              //인덱스에 해당하는 숫자가 들어가지 않았다면 그리고 해당 값이 0이 아니라면
                              tmp.add(sectionNum[i][rnd]);
                              //넣어주면서 개수 추가
                              cnt++;
                            }
                          }
                        }
                        tmp.sort();
                        numberSet.add(tmp);
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
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: numberSet.length,
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
                            width: 6,
                          );
                        },
                        itemCount: numberSet[index_ex].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index_in) {
                          return Number(numberSet[index_ex][index_in]);
                        },
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}