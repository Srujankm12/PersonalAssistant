import 'package:gpt/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:gpt/feature_box.dart';
import 'package:gpt/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService=OpenAIService();
  //bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() {});
    } else {
      // Handle the case when the speech recognition is not available
      print("Speech recognition not available");
    }
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {
      //_isListening = true;
    });
  }

  Future<void>stopListening() async {
    await speechToText.stop();
    setState(() {
     // _isListening = false;
    });
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siri'),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assests/images/ai.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
            // Chat theme
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(24),
              ),
                child: Text(
                  'Good Morning, How Can I Help You?',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                  ),
                ),
              ),

            // Features list
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 10, left: 21),
              child: const Text(
                'Check out these amazing features',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGpt',
                  DescriptionText: 'A smarter way to stay organized and informed with ChatGPT',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dall-E',
                  DescriptionText: 'Get inspired and stay creative with your personal assistant powered by Dall-E',
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  DescriptionText: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
        //backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: ()async{
          if (await speechToText.hasPermission&& speechToText.isNotListening){
            await startListening();
          }
          else if(speechToText.isListening){
           await openAIService.isArtPromptAPI(lastWords);
            await stopListening();
          }
          else{
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic_sharp),
      ) ,
    );
  }
}
