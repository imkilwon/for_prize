import 'package:flutter/material.dart';
import 'package:for_prize/widgets/show_number_widget.dart';

class HoldNumberPage extends StatefulWidget {
  const HoldNumberPage({Key? key}) : super(key: key);

  @override
  State<HoldNumberPage> createState() => _HoldNumberPageState();
}

class _HoldNumberPageState extends State<HoldNumberPage> {
  int? selectedIndex;

//ChoiceChip 선택할 수 있게 해주는 selectedIndex 선언

  List<int> numberSet = [];

//선택한 번호를 담을 numberSet

  List<bool> _isClicked = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 45; i++) {
      _isClicked.add(false);
      //전체에 다 클릭되지 않았다는 값을 넣고 시작
    }
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:Text("숫자 고정 Screen"),elevation: 5,backgroundColor: Colors.blue[800],),
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(20),
            ),
            width: screenSize.width,
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: numberSet.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left : screenSize.width/20),
                child: Number(numberSet[index]),
              ),
            ),
          ),
          SizedBox(height: screenSize.height/8,),
          Wrap(
            //가로로 길게 나열한 위젯들이 기기의 해상도를 초과할 경우
            //다음 줄에 나타날 수 있께 해주는 Wrap위젯 이용
            children: [
              for (int i = 0; i < 45; i++)
                //위젯을 여러 개 사용해야 하므로 for를 이용한다.
                ChoiceChip(
                  backgroundColor: Colors.white,
                  selectedColor: Colors.yellow,
                  //로또 번호를 선택할 수 있게 만들어주는 ChoiceChip 사용
                  label: Text("${i + 1}"),
                  //해당 ChoiceChip에 번호를 나타내야하므로 적음
                  selected: _isClicked[i],
                  //selected가 true가 되면 ChoiceChip이 선택되고 false면 선택되지 않는다.
                  onSelected: (newBool) {
                    //누르면 효과를 적어주기 위해 onSelected옵션
                    setState(() {
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
                    });
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}

Widget Number(int num) {
  if (0 < (num) && (num) <= 10) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellow,
      ),
      child: Text(num.toString()),
    );
  } else if (10 < (num) && (num) <= 20) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Text(num.toString()),
    );
  } else if (20 < (num) && (num) <= 30) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Text(num.toString()),
    );
  } else if (30 < (num) && (num) <= 40) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Text(num.toString()),
    );
  } else if (40 < (num) && (num) <= 45) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.greenAccent,
      ),
      child: Text(num.toString()),
    );
  } else {
    return Text("");
  }
}
