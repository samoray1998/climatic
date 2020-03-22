import 'package:flutter/material.dart';
class ChangeCity extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    
    // TODO: implement createState
    return changeCity();
  }
 
}
class changeCity extends State<ChangeCity>{
  var _myCityController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
      
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          image: DecorationImage(image: AssetImage("images/mountain.jpg"),colorFilter:ColorFilter.mode(Colors.blue.withOpacity(0.7), BlendMode.dstATop),fit: BoxFit.cover ),
          
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _myCityController,
                decoration: InputDecoration(
                 hintText: "Enter a City",
                 labelText: "Enter a City",
                  border:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 0.5,style:BorderStyle.solid )),filled: true,
                contentPadding: const EdgeInsets.only(left: 10),
                fillColor: Colors.white.withOpacity(0.9),
                
              ),
              ),
              SizedBox(height: 10,),
             RaisedButton(
               color:   Colors.blueAccent,
               child:Container(
                 alignment: Alignment.center,
                 width: double.infinity,
                 margin: const EdgeInsets.only(left: 10,right: 10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                 ),
                
                 child: 
                Text("Search ...!"),
               ),
               onPressed: (){
                Navigator.pop(context,{
                  'infoCity':_myCityController.text
                },);
                
               
              })
              
            ],
          ),
        ),
      ),
    );
  }

}
