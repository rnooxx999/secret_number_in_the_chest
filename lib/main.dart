import 'package:flutter/material.dart';

import 'dart:math';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() => runApp(
MaterialApp(
home: SecretNumberInTheChest()));


// colors and TextStyle
const chestTextStyle = TextStyle(
fontSize: 18, color: Colors.black,
);
const chestIconStyle = TextStyle(
fontSize: 30, color: Colors.black,
);
    const chestBackgroundColor =Color.fromRGBO(181, 182, 164, 1);
    const chestNumberColor =Color.fromRGBO(165, 164, 156, 1);
    const chestTextColor =Color.fromRGBO(187, 177, 134, 1);




class SecretNumberInTheChest extends StatefulWidget {
  @override
  _SecretNumberInTheChest createState() => _SecretNumberInTheChest();
}
class _SecretNumberInTheChest extends State<SecretNumberInTheChest> {


//the arrow that guide you if the number is below or upper than your guess
String arrow1 = "";
String arrow2 = "";
String arrow3 = "";
String aroow4 = "";

  //random numbers for the four numbers
static Random random = new Random();
  int randomNumber = random.nextInt(9) ;
    int randomNumber2 = random.nextInt(9) ;
    int randomNumber3 = random.nextInt(9) ;
    int randomNumber4 = random.nextInt(9) ;

int number1 = 0;
int number2 = 0;
int number3 = 0;
int number4 = 0;

  int numberOfTries = 0;
  int numberOfTimes = 6;

  //the method of container that have the increment and decrement buttons
Widget choicesContainer(int numb , Function incrementFun , Function decrementFun){
         return Container(height: 116,
         decoration: BoxDecoration(color: chestNumberColor,
         borderRadius: BorderRadius.circular(19)),
         child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
         Column(mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             RoundIconButton(icon: Icons.add,
            onPre: incrementFun
             ),
                        Text(numb.toString(), ),
             RoundIconButton(icon: Icons.minimize,
             onPre: decrementFun
             ),
             ],
         )],),);}


  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: chestBackgroundColor,
    appBar: AppBar(title : Text("Guss The Secret Number"),
    backgroundColor: chestBackgroundColor, ),
    body: ListView(
      children: <Widget>[
      SizedBox(height: 28,),
        Container(height: 700,
        child: Column(children: <Widget>[
        Container(height: 150,width: 180,
        decoration: BoxDecoration(image: DecorationImage(image:
         ExactAssetImage("assets/chests1.png"),fit: BoxFit.fill)),

         ),
         Padding(
           padding: const EdgeInsets.only(right :25  ,left: 25 , top: 8),
           child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             //the container that have the increment and decrement buttons
           children: <Widget>[
           //first Guess
           choicesContainer(number1, (){setState(() {if(number1 < 9){number1++;}});},
            (){setState(() {if(number1 > 0){number1--;}});}),
           //second Guess
            choicesContainer(number2, (){setState(() {if(number2 < 9){number2++;}});},
             (){setState(() {if(number2 > 0){number2--;}});}),
             //third Guess
            choicesContainer(number3, (){setState(() {if(number3 < 9){number3++;}});},
            (){setState(() {if(number3 > 0){number3--;}});}),
            //fourth Guess
           choicesContainer(number4, (){setState(() {if(number4 < 9){number4++;}});},
            (){setState(() {if(number4 > 0){number4--;}});}),


           ],),
         ),
         SizedBox(height: 19,),
         Container(width: 300,height: 60,
         decoration: BoxDecoration( color: Colors.grey,
         borderRadius: BorderRadius.circular(38),
         boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 7),
      ),
    ],
         ),
         //the arrows Container :
         child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
            arrow1.isEmpty ?
           Text("") :
              Text("${arrow1.toString()}",
              style: chestIconStyle), SizedBox(height: 10,),
            arrow2.isEmpty ?
              Text("") :
              Text("${arrow2.toString()}",
              style: chestIconStyle), SizedBox(height: 10,),
              arrow3.isEmpty ?
           Text("") :
              Text("${arrow3.toString()}",
              style: chestIconStyle), SizedBox(height: 10,),
            aroow4.isEmpty ?
              Text("") :
              Text("${aroow4.toString()}",
              style: chestIconStyle), SizedBox(height: 10,),
              ]),),
          SizedBox(height: 30,),
         //My guess BUTTON
         RaisedButton(
          onPressed: (){
          theRightAndFalseTries(); arrowsStates();
          if(number1 == randomNumber && number2== randomNumber2 &&number3== randomNumber3 &&number4== randomNumber4 ){
          _showDialog();
          }
            guess(arrow1, number1, randomNumber); guess(arrow2, number2, randomNumber2);
            guess(arrow3, number3, randomNumber3); guess(aroow4, number4, randomNumber4);

            //just for testing the number
          print(" firstNum- $randomNumber / secondNum- $randomNumber2 / thirdNum- $randomNumber3 /fourthNum- $randomNumber4");

          }, elevation: 0.5,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),side:BorderSide(color: chestTextColor)),
            child: Text("My Guess", style: TextStyle(fontSize: 19, color: Colors.black)),),

        ],))]));
  }

  void updateRandom(){
   randomNumber =random.nextInt(9); randomNumber2 = random.nextInt(9);
   randomNumber3 =random.nextInt(9); randomNumber3 = random.nextInt(9);
   setState(() {
        arrow1 = "" ; arrow2= "" ; arrow3 = "" ; aroow4 = "" ;
        number1 = 0;number2 = 0; number3 = 0;number4 = 0;
   });
  }

//method of winning or losing + the Toast
void theRightAndFalseTries(){
numberOfTries++;
    if (numberOfTries == numberOfTimes) {
      makeToast(
          "the number of tries is over");
      numberOfTries = 0;
      updateRandom();
      return;
      }
      if (number1 != randomNumber && number2!= randomNumber2 && number3 != randomNumber3 && number4!= randomNumber4) {
      makeToast("number of your tries : $numberOfTries");
    }
    else if(number1 == randomNumber && number2== randomNumber2 && number3 == randomNumber3 && number4== randomNumber4) {
      makeToast("you win ");
       _showDialog();
      numberOfTries = 0;
      updateRandom();
      return;
    }else {
      makeToast(" number of your tries : $numberOfTries");
      }
}

// below or upper Arrows for the four guesses
void arrowsStates(){
   if (number1 > randomNumber) {
     arrow1 = "↓";
    } else if (number1 < randomNumber) {
      arrow1 = "↑" ;
    } else {
      arrow1 ="☑";
    }
    if (number2 > randomNumber2) {
     arrow2 = "↓";
    } else if (number2 < randomNumber2) {
      arrow2 = "↑" ;
    } else {
      arrow2 ="☑";
    }
    if (number3 > randomNumber3) {
     arrow3= "↓";
    } else if (number3 < randomNumber3) {
      arrow3 = "↑" ;
    } else {
      arrow3 ="☑";
    }
    if (number4 > randomNumber4) {
     aroow4 = "↓";
    } else if (number4 < randomNumber4) {
      aroow4 = "↑" ;
    } else {
      aroow4 ="☑";
    }
}

//method update the arrow string and set your new guess number
void guess(String arrow , int numb ,int random) {
setState(() {
  arrow = numb.toString();});
      arrow = numb.toString();}
  void makeToast(String feedback) {
    Fluttertoast.showToast(
        msg: feedback,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        webShowClose: true,
        fontSize: 14);}


// the winning Dialog
 void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Expanded(
        child: Column(
          children: <Widget>[
                  SizedBox(height: 19,),
            Expanded(child: Text("well done you open the chest" , style: chestTextStyle,)),
            Expanded(child: Text("the secret number is : "  ,style: chestTextStyle,)),
          Expanded(
            child: Text("$randomNumber $randomNumber2 $randomNumber3 $randomNumber3",
            style: TextStyle(fontSize: 30 , color: Colors.red),),
          ),
          SizedBox(height: 30,),
           Expanded(flex: 3, child:  Image.asset("assets/chests2.png" ,width: 180 , height: 110,),),
                      Expanded(child: Text(" number of your tries : $numberOfTries"  ,style: chestTextStyle,)),],
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: chestBackgroundColor,
      backgroundColor: chestTextColor,
    );
  }
}

  //the container that have the increment and decrement buttons
class RoundIconButton extends StatelessWidget {
final IconData icon;
final Function onPre;
RoundIconButton({this.icon,this.onPre});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
    child: Icon(icon),
    elevation: 3.0,
    onPressed: onPre,
//    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    shape: CircleBorder(),
    constraints: BoxConstraints.tightFor(width: 30, height: 30),
    fillColor: chestTextColor,
    );
  }
  }
