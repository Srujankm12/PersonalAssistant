import 'package:gpt/pallete.dart';
import 'package:flutter/material.dart';
class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String DescriptionText;
  const FeatureBox({super.key,
    required this.color,
    required this.headerText,
    required this.DescriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35,
          vertical: 12),
      decoration: BoxDecoration(
          color:color,
          borderRadius:BorderRadius.all(
            Radius.circular(16),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,  ).copyWith(left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(headerText,style: TextStyle(
                  fontFamily: 'Cera Pro'
                  ,
                  color: Pallete.blackColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(DescriptionText,
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,

                ),),
            )
          ],
        ),
      ),
    );

  }
}
