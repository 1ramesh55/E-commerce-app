import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final GestureTapCallback onPressed;
  final bool? outlineBtn;
  final bool? isloading;

  const CustomBtn(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.outlineBtn,
      this.isloading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? _outlineBtn = outlineBtn ?? false;
    bool? _isloading = isloading ?? false;
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isloading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _outlineBtn ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Visibility(
              visible: _isloading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
