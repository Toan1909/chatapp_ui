import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  SettingItem({super.key, required this.title, required this.desc, required this.icon});
  double heightWidget = 44;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: heightWidget,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22)),
                color: Color(0xFFDEEBFF)),
            width: heightWidget,
            height: heightWidget,
            child:Icon(
              icon,
              color: const Color(0x63797C7B),
              size: 24,
            ),
          ),
          const SizedBox(width: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF000E08),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Visibility(
                visible: desc!='',
                child: Text(
                  desc,
                  style: const TextStyle(
                    color: Color(0x63797C7B),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
