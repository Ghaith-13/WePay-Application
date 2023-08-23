import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Our Services",
            style: TextStyle(fontSize: 40.0.sp, color: Colors.grey[300]),
          ),
          SizedBox(
            height: 75.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 75.0.r,
                    child: Image.asset(
                      'assets/PaymentSection.png',
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Payment Section",
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                ],
              ),
              SizedBox(
                width: 40.0.w,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 75.0.r,
                    child: Image.asset(
                      'assets/PaymentSection.png',
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Payment Section",
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 75.0.r,
                    child: Image.asset(
                      'assets/PaymentSection.png',
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Payment Section",
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                ],
              ),
              SizedBox(
                width: 40.0.w,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 75.0.r,
                    child: Image.asset(
                      'assets/PaymentSection.png',
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Payment Section",
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
