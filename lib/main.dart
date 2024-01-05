import 'package:chatgpt_test/test.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'onePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
      themeMode: ThemeMode.system,
      home: const OnePage(),
    );
  }
}

// class FirstPage extends StatefulWidget {
//   const FirstPage({Key? key}) : super(key: key);
//
//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }
//
// class _FirstPageState extends State<FirstPage> {
//   TextEditingController apiKeyController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Test project"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("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"),
//             SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 45, right: 45),
//               child: TextField(
//                 controller: apiKeyController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'apiKey',
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     apiKey = value;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ElevatedButton(
//               onPressed: (apiKey.isNotEmpty)
//                   ? () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const OnePage()));
//                     }
//                   : null,
//               child: const Text(
//                 'Test Page',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  make text to prompt
// Future<String> generateText(
//     String situation, List<String> emotion, List<String> resultSitu) async {
//   String emotionsTemp = '';
//   String situationTemp = '';
//   OpenAI.apiKey = apiKey;
//
//   try {
//     //  situation analysis
//     final situationGPT = await OpenAI.instance.chat.create(
//       //  사용하는 모델
//       model: 'gpt-3.5-turbo',
//       //  출력의 최대 토큰 수 (기본값; 50)
//       maxTokens: 50,
//       //  창의성, 수치와 비례함 (기본값: 0.5)
//       temperature: 0,
//       //  답변의 확률 분포 상위 p%, 단어의 다양성 (기본값: 1)
//       topP: 1,
//       //  중복되는 구문 생성 방지 (기본값: 0)
//       frequencyPenalty: 0,
//       //  답변의 특정 키워드 제거 (기본값: 0)
//       presencePenalty: 0,
//       messages: [
//         OpenAIChatCompletionChoiceMessageModel(
//           content:
//           "너는 전문 상황 분석가로 요구에따라 핵심 상황을 파악해야해. 다음의 일기에서 파악되는 상황을 <가족, 연애, 친구관계, 직장, 학교, 군대, 진로, 일상생활, 공부, 일, 건강, 종교, 운동, 취미생활, 돈, 불면, 자존감, 날씨> 중에서만 최대 3개를 선택해서 정리해. <$situation>, 정리한 내용은 반드시 다음 형식으로 만들어 <[단어, 단어, ...]>",
//           role: OpenAIChatMessageRole.system,
//         ),
//       ],
//     );
//
//     //  emotion analysis
//     final emotionGPT = await OpenAI.instance.chat.create(
//       //  사용하는 모델
//       model: 'gpt-3.5-turbo',
//       //  출력의 최대 토큰 수 (기본값; 50)
//       maxTokens: 50,
//       //  창의성, 수치와 비례함 (기본값: 0.5)
//       temperature: 0,
//       //  답변의 확률 분포 상위 p%, 단어의 다양성 (기본값: 1)
//       topP: 1,
//       //  중복되는 구문 생성 방지 (기본값: 0)
//       frequencyPenalty: 0,
//       //  답변의 특정 키워드 제거 (기본값: 0)
//       presencePenalty: 0,
//       messages: [
//         OpenAIChatCompletionChoiceMessageModel(
//           content:
//               "너는 전문 감정 분석가로 요구에따라 핵심 감정을 파악해야해. 다음으로 오는 일기에서 파악되는 감정을 <기쁨, 감사, 기대, 설렘, 놀람, 지루함, 피곤함, 짜증남, 무기력, 우울함, 슬픔, 화남, 감정 없음> 중에서만 최대 3개를 선택해서 정리해. <$situation>, 정리한 내용은 반드시 다음 형식으로 만들어 <[단어, 단어, ...]>",
//           role: OpenAIChatMessageRole.system,
//         ),
//       ],
//     );
//
//     //  result to variables
//     situationTemp = situationGPT.choices.first.message.content;
//     emotionsTemp = emotionGPT.choices.first.message.content;
//
//     //  split emotions into List<String>
//     emotion = emotionsTemp
//         .substring(1, emotionsTemp.length - 1)
//         .split(', ')
//         .map((value) => value.trim())
//         .toList();
//     resultSitu = situationTemp
//         .substring(1, situationTemp.length - 1)
//         .split(', ')
//         .map((value) => value.trim())
//         .toList();
//
//     for (int i = 0; i < emotion.length; i++) {
//       print(emotion[i]);
//     }
//     for (int i = 0; i < resultSitu.length; i++) {
//       print(resultSitu[i]);
//     }
//   } catch (e) {
//     situation = 'error';
//     emotion.add('error');
//     print('Error');
//   }
//
//   return '상황: $situationTemp \n감정: $emotionsTemp';
// }

//  result one page
// class ResultPageOne extends StatefulWidget {
//   final String prompt;
//   const ResultPageOne({super.key, required this.prompt});
//
//   @override
//   State<ResultPageOne> createState() => _ResultPageOneState();
// }
//
// class _ResultPageOneState extends State<ResultPageOne> {
//   List<String> emotionsWOW = List<String>.empty(growable: true);
//   List<String> situationWOW = List<String>.empty(growable: true);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Summerization"),
//       ),
//       // body: Text(widget.situation, String think, String emotion),
//       body: //  AI analyzation result
//           FutureBuilder<String>(
//         future: generateText(widget.prompt, emotionsWOW, situationWOW),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Padding(
//               padding: const EdgeInsets.only(top: 50),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(snapshot.data.toString()),
//                     /*
//                     for (int i = 0; i < situationWOW.length; i++)
//                       Text(
//                         situationWOW[i],
//                       ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     for (int i = 0; i < emotionsWOW.length; i++)
//                       Text(
//                         emotionsWOW[i],
//                       ),
//                       */
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
