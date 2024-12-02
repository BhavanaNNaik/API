import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WeatherInfo(),
      
    );
  }
  }


class WeatherInfo extends StatefulWidget{
  const WeatherInfo({super.key});

  
  @override
  
  _WeatherInfoState createState()=> _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo>{

  final cityController = TextEditingController();
  String _weatherInfo=" ";
  
   Future<void> fetchweather(String city) async{
    
    final URL="https://api.weatherstack.com/current?access_key=8886408c5fab3351f4baa0d387f4f9fc&query=$city";

    try{
      final response =await http.get(Uri.parse(URL));
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        setState(() {
        _weatherInfo="Temperature:${data["current"]["temperature"]}°C\n Description: ${data["current"]["weather_descriptions"].join(",")}";
        });
      }
      else{
        setState(() {
          _weatherInfo="City not found";
        });
      }
    }catch(e){
      setState(() {
        _weatherInfo="Unable to featch the data";
      });
    }
   }
   
     @override
     Widget build(BuildContext context) {
      return Scaffold(
        appBar:AppBar(title:const Text("Weather"),
        backgroundColor: const Color(0xFF7F9BA6), // AppBar background color
        foregroundColor: Colors.white), // Title text color),
        backgroundColor: const Color(0xFFF1F1F1),
        body:Center(
          child:Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  label:const Text("Enter the city"),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black))
                  
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(onPressed: (){
               if (cityController.text.isNotEmpty) {
                fetchweather(cityController.text);
               } else {
                setState(() {
                  _weatherInfo = "Please enter a city name.";
               });
               }

              }, child:const Text("fetch Data"),
             style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black), // Set the background color here
              foregroundColor: WidgetStateProperty.all(Colors.white), // Set the text color here
              ),
              ),
              const SizedBox(height: 20),

               Text(
              _weatherInfo,
              style: const TextStyle(fontSize: 16, fontWeight:FontWeight.bold),
              textAlign: TextAlign.center,
                     
            ),
            ],
            )
          ))
      );
   
     }

}