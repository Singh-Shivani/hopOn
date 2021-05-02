import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/ride_history_page.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final AsyncSnapshot<VehicleUser> docSnapshot;
  final String pickupDate;
  final String dropOffDate;

  PaymentPage({@required this.amount,@required this.docSnapshot, @required this.pickupDate,
    @required this.dropOffDate});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    openCheckOut();
  }
  //TODO : Remove RAZORPAY KEY Afterwards
  // rzp_test_l8yCRSz3UfiXKB
  // qKex1KtIwjUAfxYJtZVUUjaw

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess() {
    Toast.show('Payment Successful', context);
    print('handlerPaymentSuccess');
    saveHistory();

  }

  void saveHistory(){
    DatabaseReference dbref = FirebaseDatabase.instance
        .reference()
        .child('user_history/${currentFirebaseUser.uid}/$bookedCar');

    Map historyMap = {
      'ownerId' : bookedCar,
      'modelName' : widget.docSnapshot.data.modelName,
      'color': widget.docSnapshot.data.color,
      'ownerName' :  widget.docSnapshot.data.ownerName,
      'vehicleNumber' : widget.docSnapshot.data.vehicleNumber,
      'amount' : widget.amount,
      'pickupDate' :  widget.pickupDate,
      'dropofDate' : widget.dropOffDate

    };

    dbref.set(historyMap);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RideHistory(),
      ),
    );

  }

  void handlerErrorFailure() {
    Toast.show('Payment Failed', context);
    print('handlerErrorFailure');
  }

  void handlerExternalWallet() {
    print('handlerExternalWallet');
  }

  void openCheckOut() {
    var options = {
      'key': "rzp_test_l8yCRSz3UfiXKB",
      'amount': (int.parse(widget.amount) * 100).toString(),
      'description': 'Your ride',
      "prefill": {
        "contact": '9876543210',
        "email": FirebaseAuth.instance.currentUser.email,
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TextFormField(
          //   initialValue: widget.amount,
          // ),
        ],
      ),
    );
  }
}
