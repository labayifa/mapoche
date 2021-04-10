import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetButtonStandard extends StatelessWidget {

  final String buttonName;

  WidgetButtonStandard({@required this.onPressed, this.buttonName, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context);
    return new Card(
        color: Colors.blue,
        elevation: 6,
        child: MaterialButton(
          child: SizedBox(
            width: 300,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                        this.buttonName,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 15,
                            fontFamily: "Roboto"
                        )
                    ),

                  ],
                )),
          ),
          onPressed: onPressed,
        ),
        shape: const StadiumBorder(
        )
    );
  }
  final GestureTapCallback onPressed;
}
