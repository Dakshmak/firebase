import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool loding;
  const RoundButton({Key? key, this.loding = false , required this.title, required this.onTap}) : super(key: key);

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
          child: Center(child: widget.loding ? CircularProgressIndicator(color: Colors.white,strokeWidth: 5,) : Text(widget.title.toString()),),
        ),
      ),
    );
  }
}
