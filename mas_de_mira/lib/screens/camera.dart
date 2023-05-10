import 'dart:convert';
import 'dart:typed_data';
import 'package:aws_polly/aws_polly.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mas_de_mira/constants.dart';
import 'dart:io';
import 'dart:async';
import 'package:aws_s3/aws_s3.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);
  

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture = Future.value(null);
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  bool _isCameraReady = false;  

  Future<void> getCamera() async{
    cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    camera = cameras[0];
  }


  Future<String?> uploadImageToS3(File image, String imgName) async {
  String url = "${IMG_UPLOAD_API_URL}/${imgName}";
  Dio dio = new Dio();

  try {
    await dio.put(
      url,
      data: image.openRead(),
      options: Options(
        contentType: "image/jpeg",
        headers: {
          "Content-Length": image.lengthSync(),
        },
      ),
      onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = sentBytes / totalBytes * 100;
        print("$progressPercent %");
      },
    );
    return "200";
  } catch (error) {
    if (error is DioError) {
      return error.response?.statusCode?.toString();
    } else {
      throw Exception('Failed to upload image');
    }
  }
}

  Future<String> getPrediction(String imgName) async {
    const apiUrl = "${PREDICTION_API_URL}";

    final headers = {'Content-Type': 'application/json'};
    final jsonBody = json.encode({'photo': imgName});
    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get prediction: ${response.statusCode}');
    }
  }

  Future<void> sayPred(String prediction) async {
    
    final AwsPolly _awsPolly = AwsPolly.instance(
      poolId: "${POOL_ID}",
      region: AWSRegionType.USEast1,
    );

    final url = await _awsPolly.getUrl(
        voiceId: AWSPolyVoiceId.conchita,
        input: prediction,
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
    getCamera().then((_) {
      _controller = CameraController(camera, ResolutionPreset.ultraHigh);
      _initializeControllerFuture = _controller.initialize().then((_) {
        setState(() {
          _isCameraReady = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.amazonblack,
      child: 
      Column(children: [
        FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if(_isCameraReady && snapshot.connectionState == ConnectionState.done){
            return Expanded(
              child: RotatedBox(
                quarterTurns: 1,
                child: CameraPreview(_controller),
              )
            );
          }else{
            return const Center(child: 
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.amazonorange), // change color
              strokeWidth: 5, // change thickness
              backgroundColor: AppConstants.lightgrey, // change background color
              semanticsLabel: 'Cargando Cámera',
            )
            );
          }
        },
    ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            backgroundColor: AppConstants.amazonorange,
              // Provide an onPressed callback.
              onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
        
            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await _controller.takePicture();
            String imgName = "captura-${DateTime.now().toString().replaceAll(' ', '_')}.jpg";

            // Upload the image to S3 using your backend API
            final response = await uploadImageToS3(File(image.path), imgName);

            final prediction = await getPrediction(imgName);

            //await sayPrediction();

            await sayPred(prediction);

            if (!mounted) return;
            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CapturedImageScreen(imagePath: image.path)),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
              },
              child: const Icon(Icons.camera_alt),
              ),
        ),
    ],),
    );
  }
}

class CapturedImageScreen extends StatelessWidget {
  final String imagePath;

  const CapturedImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Imagén Capturada',
        style: TextStyle(
          fontFamily: "Amazon",
        ),),
        backgroundColor: AppConstants.amazonorange,
        ),
      body: 
      Image.file(File(imagePath)),
    );
  }
}
