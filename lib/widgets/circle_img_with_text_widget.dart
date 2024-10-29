import 'package:chatapp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef MyCallback = void Function();
class CircleImageWithTextUnder extends StatelessWidget {
  const CircleImageWithTextUnder({
    super.key,this.haveStory=false,this.isUser=false,required this.sizeZ, required this.urlImg, required this.callback,this.text='', this.style = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600),
  });
  final double sizeZ;
  final String urlImg;
  final MyCallback callback;
  final String text;
  final TextStyle style;
  final bool haveStory ;
  final bool isUser ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: haveStory,
                  child: Container(
                    width: sizeZ,
                    height: sizeZ,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color.fromRGBO(251, 170, 71, 1),Color.fromRGBO(217, 26, 70, 1),Color.fromRGBO(166, 15, 147, 1)],
                        )
                    ),
                  ),
                ),
                Container(
                  width: sizeZ-5,
                  height: sizeZ-5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: sizeZ-10,
                  height: sizeZ-10,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(urlImg),
                  ),
                ),
                SizedBox(
                  width: sizeZ-10,
                  height: sizeZ-10,
                  child: Visibility(
                    visible: isUser,
                    child: Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(top: 30,left: 30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white,
                            width: 3),
                      ),
                      child: const Icon(Icons.add, size: 16,color: Colors.black,),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            Visibility(
              visible: text!="",
              child: SizedBox(
                width: 64,
                child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  style: style,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}