import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_sPQCMsF8LidQn8",
      "amount": num.parse(textEditingController.text)*100,
      "name": "Sample App",
      "description": "Payment for the some product",
      "prefill": {
        "contact": "9930782439",
        "email": "gautamyadav422@gmail.com",
      },
      "external": {
        "wallet": ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment Success");
    Fluttertoast.showToast(msg: "Payment Success");
  }

  void handlerErrorFailure() {
    print("Payment fail");
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void handlerExternalWallet() {
    print("Payment wallet");
    Fluttertoast.showToast(msg: "Payment External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Razor Pay"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/s12.jpg",height: 300,),
              ),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: TextField(
                  keyboardType: TextInputType.number,
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: "Enter Amount to pay"),
              ),
                ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  openCheckout();
                },
                child: Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
