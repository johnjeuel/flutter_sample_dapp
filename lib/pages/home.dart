import 'package:flutter/material.dart';
import 'package:flutter_basic_dapp/models/ethereum_utils.dart';
import 'package:flutter_basic_dapp/widgets/app_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EthereumUtils _ethereumUtils = EthereumUtils();

  double? _value = 0.0;
  
  var _data;
  
  @override
  void initState() {
    _ethereumUtils.initial();
    print('vasdasd');
    _ethereumUtils.getBalance().then((value) {
      print('value? $value');
      _data = value;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text("DAPP"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.deepPurple..withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      const Text(
                        "Current Balance",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _data == null ? const CircularProgressIndicator()
                      : Text(
                        '$_data',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SfSlider(
                value: _value,
                onChanged: (v) {
                  setState(() {
                    _value = v;
                  });
                },
              interval: 1,
              activeColor: Colors.white,
              enableTooltip: true,
              stepSize: 1,
              showLabels: true,
              min: 0,
              max: 10,
            ),
            const SizedBox(height: 40,),
            AppButton(title: "Send Balance", color: Colors.green, onTap: () async {
              await _ethereumUtils.sendBalance(_value!.toInt());

              if(_value == 0) {
                errorInputDialog(context);
              } else {
                sendDialog(context);
              }
            }),
            const SizedBox(height: 40,),
            AppButton(title: "Withdraw Balance", color: Colors.deepPurple, onTap: () async {
              await _ethereumUtils.withDraw(_value!.toInt());
              if(_value == 0) {
                errorInputDialog(context);
              } else {
                withDrawDialog(context);
              }
            }),
            const SizedBox(height: 40,),
            AppButton(title: "Balance Inquiry", color: Colors.deepOrange, onTap: (){
              _ethereumUtils.getBalance().then((value) {
                _data = value;
                setState(() {

                });
              });
            }),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}

errorInputDialog(BuildContext ctx) {
  return showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Invalid Value',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ),
          ),
          content: const Text('Please put a value greater than 0.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87
            ),),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

sendDialog(BuildContext ctx) {
  return showDialog(
      context: ctx,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Send success",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      });
}

withDrawDialog(BuildContext ctx) {
  return showDialog(
      context: ctx,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Thanks for withdrawing",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      });
}
