import 'package:chatgpt_test/main.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

const apiKey = "";
const apiUrl = 'https://api.openai.com/v1/completions';

class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> submittedTexts = ["예시: 2023년 1월 2일 뭐했더라??", "집에 누워있었어"];
  String openaiResponse = '';
  List emotion = ["😮‍💨", "🤔", "😭", "😝", "😩"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("과거의 나와 대화하기"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45, top: 45),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '나의 기록',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200, // Set a fixed height for the ListView.builder
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                              onTap: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierColor: Colors.black54,
                                  // space around dialog
                                  transitionDuration:
                                      Duration(milliseconds: 800),
                                  transitionBuilder: (context, a1, a2, child) {
                                    return ScaleTransition(
                                        scale: CurvedAnimation(
                                            parent: a1,
                                            curve: Curves.elasticOut,
                                            reverseCurve: Curves.easeOutCubic),
                                        child: dialog(context, index));
                                  },
                                  pageBuilder: (BuildContext context,
                                      Animation animation,
                                      Animation secondaryAnimation) {
                                    return Container();
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/images/${index + 1}.png",
                                    width: 200, // Adjust width as needed
                                    height: 200, // Adjust height as needed
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 75),child: Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amberAccent,
                                      child: Text(
                                        emotion[index],
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ), )

                                ],
                              ))),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () async {
                  String userMessage = _controller.text;
                  setState(() {
                    submittedTexts.add(userMessage);
                    _controller.clear();
                  });

                  // 호출할 GPT-3.5 Turbo 모델을 설정
                  OpenAI.apiKey = apiKey;
                  final response = await OpenAI.instance.chat.create(
                    model: "gpt-4",
                    messages: [
                      const OpenAIChatCompletionChoiceMessageModel(
                        content:
                            "답을 해줄 때는 친구한테 말하는 것처럼 반말로 해줘. 아래 일기는 나의 일기들이다. 즉 나의 과거이다.\n[\n일기 1: 2023년 10월 23일 수업과 스터디\n오늘은 수업과 스터디로 가득 찬 하루였다. 강의에서는 매우 어려운 내용을 들었으며, 스터디에서는 친구들과 함께 과제를 푸는 시간을 가졌다… 교수님 취향이 좀 지독한 것 같다. 무고한 학생들이나 이렇게 괴롭히고 말이다. 진짜 김경록, 김형진 없었으면 자퇴하지 않았을까 싶기도;;\n\n일기 2: 2023년 11월 11일 새로운 친구 만나기\n2024년 봄학기가 새로 시작되었다. 낯가림이 심하지만, 친구들이 모두 군대에 가서 어떻게든 친구들을 사귀어야 한다. 안 그러면 밥을 혼자 못 먹어서 굶어야 한다… 마이쮸.. 효과는 굉장했다. 곧 벛꽃도 필 텐데, 친구 중에 여자 친구도 있었으면 좋겠다.\n\n일기 3: 2023년 11월 14일 과제와의 싸움\n2주 동안 미루고 미루던 전공 과제가 내일 자정까지다. 망했다. 새벽까지 밤새우면서 과제를 했는데… 뭐 일단 끝낸 거에 의미를 두기로 하였다 하핳. 과제 끝났으니, 이제 양심의 가책 없이 놀 수 있다.\n\n일기 4: 2024년 1월 3일 카페에서의 시간\n오늘은 경록이와 카페에 가서 시간을 보냈다. 학교 도서관은 너무 답답하고, 또 이야기할 수 있는 곳은 사람이 너무 많아서 카페로 왔다. 창가 쪽에 앉아서 카라멜마키야도를 마시며 책을 읽으려고 했지만, 경록이가 여자 친구와 싸웠다는 이야기를 나누며 책은 한페이지도 넘길 수 없었다. 그래도 나름 재미있었기에 책 따위 신경 쓰지 않는다.\n\n일기 5: 2024년 1월 4일 스트레스와의 싸움\n망할 매일 과제도 미루었는데, 수업을 제대로 들었을 리가 없지. 망할 교수님들은 항상 과제와 시험을 다 같이 날짜를 짜는 건가. 어떻게 다음 주까지 시험과 과제가 10개가 넘는 거야… 엄청난 압박감이다. 이대로 시작했다가는 번아웃이 올 것이다. 운동이나 해야지. 그리고 그 운동을 하면 안 됐다. 운동을 하니 피곤해서 과제와 공부는 일절 못하고 나에게 숙면을 허락해 버렸다.\n]",
                        role: OpenAIChatMessageRole.system,
                      ),
                      OpenAIChatCompletionChoiceMessageModel(
                        content: userMessage,
                        role: OpenAIChatMessageRole.user,
                      ),
                    ],
                    //  출력의 최대 토큰 수 (기본값; 50)
                    maxTokens: 500,
                    //  창의성, 수치와 비례함 (기본값: 0.5)
                    temperature: 0,
                    //  답변의 확률 분포 상위 p%, 단어의 다양성 (기본값: 1)
                    topP: 1,
                    //  중복되는 구문 생성 방지 (기본값: 0)
                    frequencyPenalty: 0,
                    //  답변의 특정 키워드 제거 (기본값: 0)
                    presencePenalty: 0,
                  );

                  setState(() {
                    openaiResponse = response.choices.first.message.content;
                    print(response.choices);
                    submittedTexts.add(openaiResponse);
                  });
                },
                child: const Text("제출하기"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '채팅:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (submittedTexts.isNotEmpty)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      for (int index = 0;
                          index < submittedTexts.length;
                          index++)
                        Align(
                          alignment: index.isOdd
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              submittedTexts[index],
                              maxLines: null,
                              softWrap: true,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialog(BuildContext context, index) {
    List diary = [
      "2023년 10월 23일 수업과 스터디\n\n오늘은 수업과 스터디로 가득 찬 하루였다. 강의에서는 매우 어려운 내용을 들었으며, 스터디에서는 친구들과 함께 과제를 푸는 시간을 가졌다… 교수님 취향이 좀 지독한 것 같다. 무고한 학생들이나 이렇게 괴롭히고 말이다. 진짜 김경록, 김형진 없었으면 자퇴하지 않았을까 싶기도;;",
      "2023년 11월 11일 새로운 친구 만나기\n\n2024년 봄학기가 새로 시작되었다. 낯가림이 심하지만, 친구들이 모두 군대에 가서 어떻게든 친구들을 사귀어야 한다. 안 그러면 밥을 혼자 못 먹어서 굶어야 한다… 마이쮸.. 효과는 굉장했다. 곧 벛꽃도 필 텐데, 친구 중에 여자 친구도 있었으면 좋겠다.",
      "2023년 11월 14일 과제와의 싸움\n\n2주 동안 미루고 미루던 전공 과제가 내일 자정까지다. 망했다. 새벽까지 밤새우면서 과제를 했는데… 뭐 일단 끝낸 거에 의미를 두기로 하였다 하핳. 과제 끝났으니, 이제 양심의 가책 없이 놀 수 있다.",
      "2024년 1월 3일 카페에서의 시간\n\n오늘은 경록이와 카페에 가서 시간을 보냈다. 학교 도서관은 너무 답답하고, 또 이야기할 수 있는 곳은 사람이 너무 많아서 카페로 왔다. 창가 쪽에 앉아서 카라멜마키야도를 마시며 책을 읽으려고 했지만, 경록이가 여자 친구와 싸웠다는 이야기를 나누며 책은 한페이지도 넘길 수 없었다. 그래도 나름 재미있었기에 책 따위 신경 쓰지 않는다.",
      "2024년 1월 4일 스트레스와의 싸움\n\n망할 매일 과제도 미루었는데, 수업을 제대로 들었을 리가 없지. 망할 교수님들은 항상 과제와 시험을 다 같이 날짜를 짜는 건가. 어떻게 다음 주까지 시험과 과제가 10개가 넘는 거야… 엄청난 압박감이다. 이대로 시작했다가는 번아웃이 올 것이다. 운동이나 해야지. 그리고 그 운동을 하면 안 됐다. 운동을 하니 피곤해서 과제와 공부는 일절 못하고 나에게 숙면을 허락해 버렸다.\n"
    ];
    return Dialog(
        child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
          margin: EdgeInsets.only(top: 40, bottom: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          width: 400,
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: Text(diary[index]),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("나가기"))
            ],
          )),
    ));
  }
}
