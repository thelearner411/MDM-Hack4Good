import 'package:aws_polly/aws_polly.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mas_de_mira/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> groceryList = ["Manzanas", "Pollo", "Broccoli",
  "Cebolla Roja", "Ajo", "Lechuga", "Arroz Integral",
  "Pavo", "Zanahoria", "Harina", "Berenjena", "Tomates", "Plátanos"];


  Future<void> sayList(String listString) async {
    
    final AwsPolly _awsPolly = AwsPolly.instance(
      poolId: '${POOL_ID}',
      region: AWSRegionType.USEast1,
    );

    final url = await _awsPolly.getUrl(
        voiceId: AWSPolyVoiceId.conchita,
        input: listString,
    );

    if (url != null){
      final player = AudioPlayer();
      player.setUrl(url);
      player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    String listString = "Tu lista es así: ${groceryList.join(", ")}";
    sayList(listString);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppConstants.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppConstants.lightgrey,
                  ),
                ], 
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    for (var item in groceryList) ...{
                    Text(
                      item,
                      style: TextStyle(
                        fontFamily: "Amazon",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                  },           
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}