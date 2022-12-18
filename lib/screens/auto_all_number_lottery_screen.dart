import 'dart:math';

import 'package:flutter/material.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class AutoAllNumberLotteryScreen extends StatefulWidget {
  const AutoAllNumberLotteryScreen({Key? key}) : super(key: key);

  @override
  State<AutoAllNumberLotteryScreen> createState() =>
      _AutoAllNumberLotteryScreenState();
}

class _AutoAllNumberLotteryScreenState
    extends State<AutoAllNumberLotteryScreen> {
  List<List<int>> numberSet = [];

  @override
  Widget build(BuildContext context) {
    List<int> tmp = [];
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
                  "자동으로 \n번호 추첨하기",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tmp.clear();
                        //여러 번 누를 수 있기 때문에 누를 때마다 clear할 수 있게 만듦
                        while (true) {
                          var rnd = Random().nextInt(45) + 1;
                          //1~45까지 수에서 랜덤하게 하나씩 뽑음

                          if (!tmp.contains(rnd)) {
                            //lottoSet에 랜덤 숫자가 없다? == 중복되지 않은 숫자
                            tmp.add(rnd);
                            //lottoSet에 넣음
                          }
                          if (tmp.length == 6) {
                            tmp.sort();
                            var result = tmp;
                            numberSet.add(result);
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
                            width: 14,
                          );
                        },
                        itemCount: 6,
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
