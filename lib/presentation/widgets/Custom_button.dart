import 'package:flutter/material.dart';

import 'Custom_Text.dart';



  class CustomButton extends StatelessWidget {

  final String  text;
  final Function  onPressed;
  final Color  color1,color2;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color1,
    required this.color2,
  });


  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        child: SizedBox(
          width:155,
          height:52,
          child:Card(
            color:color1,
            child:Center(
              child:Custom_Text(
                text: text,
                fontSize: 17,
                alignment: Alignment.center,
                color: color2,
              ),
            ),
          )

        ),
          onTap:(){
            onPressed();
          }
      );



    }
}