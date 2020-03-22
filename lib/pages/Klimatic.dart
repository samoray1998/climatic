import 'package:flutter/material.dart';
import 'package:klimatic/pages/ChangeCity.dart';
import '../pages/utils/utils.dart'as utils;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Klimatic extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new klimatic();
      }
    
    }
    
    class klimatic extends State<Klimatic>{
      String cityEntered="rabat";
      Future gotoChangeCity(BuildContext context)async{
        Map result=await Navigator.of(context).push(
          new MaterialPageRoute<Map>(builder: (BuildContext context)=>ChangeCity())
        );
        if (result!=null&&result.containsKey('infoCity')) {
          print("yes you did it "+result['infoCity'].toString());
          cityEntered=result['infoCity'].toString();
        
        } else {
           print("you scrod up ...");
           cityEntered=utils.defaultCity;
        }
      }

  @override
  Widget build(BuildContext context) {
    final double h=MediaQuery.of(context).size.height*0.65;
    TextStyle _cityStyle(){
      return TextStyle(color: Colors.grey[100],fontSize: 22.5,fontStyle:FontStyle.italic);
    }
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0,0 , 0, 0),
            width: double.infinity,
            height:double.infinity,
            decoration: BoxDecoration(
             color: Colors.blueAccent,
              image: DecorationImage(colorFilter: ColorFilter.mode(Colors.blueAccent.withOpacity(0.7), BlendMode.dstATop),image: AssetImage("images/weather.jpg"),fit: BoxFit.fill)
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.centerRight,
                 
                  child: IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed:(){gotoChangeCity(context);}),
                ),
               Container(
           alignment: Alignment.centerRight,
           margin: const EdgeInsets.only(right: 10),
            child: Text('$cityEntered',style: _cityStyle(),),
          ),
        SizedBox(height: 180,),
        
          Center(child: 
           Container(

              alignment: Alignment.centerLeft,
              width: double.infinity,
           height: 100,
              margin: const EdgeInsets.fromLTRB(40,0 ,0,0),
             decoration: BoxDecoration(
               image: DecorationImage(image: AssetImage("images/light_rain.png"))
             ),
            
            ),
          ),
           
            // Container(
            //   margin: const EdgeInsets.only(left: 65),
            //   width: double.infinity,
            //   height: 40,
            //   child: Text("67.09F",style: TextStyle(color: Colors.white,
            //   fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 25 ),),
            // )
            updatedata(cityEntered),


            ],),
          )
         
         
        ],
      ),
    );
  }
  Future<Map> getWeather(String apiID,String city) async{
    String apiUrl="http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiID&units=imperial";
    http.Response response= await http.get(apiUrl);
    return json.decode(response.body);
   
  }
  void showdata()async{
  Map data=await  getWeather(utils.apiID, utils.defaultCity);
  print(data.toString());

  }
  Widget updatedata(String city){
    return new FutureBuilder(future:getWeather(utils.apiID, city),builder: (BuildContext context,AsyncSnapshot<Map> snapshot){
      if (snapshot.hasData) {
        Map content=snapshot.data;
        return new Container(
          alignment: Alignment.centerRight,
          width: 500,
          child: Column(children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 40),
              title: new Text(content['main']['temp'].toString()+' F',style: TextStyle(color: Colors.white,
              fontStyle: FontStyle.normal,fontWeight:FontWeight.w500,fontSize:49 ),),
              subtitle: Text('Humidity :${content['main']['humidity'].toString()}\n'+
                            'Min :${content['main']['temp_min'].toString()} F\n'+ 
                             'Max :${content['main']['temp_max'].toString()} F',style:TextStyle(color: Colors.grey[100],fontSize: 22.5,fontStyle:FontStyle.italic),
                            
              ),
            )
          ],),

        );
        
      } else {
        new Container();
      }

    });
  }
}