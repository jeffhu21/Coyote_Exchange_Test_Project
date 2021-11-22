import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(MaterialApp(
  home: CoyoteExchange(),
));



class CoyoteExchange extends StatefulWidget {
  //const CoyoteExchange({Key? key}) : super(key: key);

  @override
  _CoyoteExchangeState createState() => _CoyoteExchangeState();
}

class _CoyoteExchangeState extends State<CoyoteExchange> {

  var str = "";
  bool isLoading = false;


  Future<void> startLoading() async
  {
    setState((){
      isLoading = true;
      new Future.delayed(new Duration(seconds:3),loading);
    });

    /*
    await Future.delayed(Duration(seconds:200),(){
      setState((){
        isLoading=false;
      });
    });
     */
  }

  Future<void> loading() async
  {
    setState((){
      isLoading=false;
    });
  }


  Future<void> getCurrencyRate(String base) async
  {
    String api_key = "8ce66b2a404d9cd85954dcd9";

    try
    {
      Response r = await get(Uri.parse('https://v6.exchangerate-api.com/v6/$api_key/latest/$base'));
      Map data = jsonDecode(r.body);

      var exchangeRate = data['conversion_rates'];

      setState((){
        str = "";
        str += "CAD:" + exchangeRate['CAD'].toString() + '\n';
        str += "JPY:" + exchangeRate['JPY'].toString() + '\n';
        str += "GBP:" + exchangeRate['GBP'].toString() + '\n';
        str += "USD:" + exchangeRate['USD'].toString() + '\n';
        str += "EUR:" + exchangeRate['EUR'].toString() + '\n';
      });


      //print(str);


    }
    catch(e)
    {
      print('Error! $e');
    }
  }

  Column _countryColumn(String url, String label)
  {
    return Column(
      children:[
        Column(

          children: [

            IconButton(
              icon: new Image.asset(url),
              onPressed: () {
                //print(label);

              startLoading();



                getCurrencyRate(label);
              },

            ),
            Text(label),
          ],
        ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Coyote Exchange'),
        centerTitle:true,
      ),

      body:
      Padding(
        padding:EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 0.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Center(

                child:
                Image(
                  image: AssetImage('assets/cx_logo.jpg'),
                ),
              ),


              SizedBox(height: 20.0),


              /*
              SpinKitSquareCircle(
                controller: AnimationController(vsync: this,duration:const
                Duration(seconds:4)),
              ),
              */

              //SizedBox(height: 15.0),


              //Row(
              Wrap(

                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                alignment: WrapAlignment.center,
                spacing: 24.0,
                children:[

                  _countryColumn('assets/canada.jpg','CAD'),
                  _countryColumn('assets/japan.jpg','JPY'),
                  _countryColumn('assets/uk.jpg','GBP'),
                  _countryColumn('assets/usa.jpg','USD'),
                  _countryColumn('assets/france.jpg','EUR'),
                  _countryColumn('assets/germany.jpg','EUR'),
                  _countryColumn('assets/italy.jpg','EUR'),

                ],
              ),

              SizedBox(height: 30.0),

              Center(

                /*
                child:
                Text(str),
                 */

                //child: isLoading ? (Text('Loading...')) : (Text(str)),
                child: isLoading ? (CircularProgressIndicator()) : (Text(str)),

              ),

            ],
          ),
      ),
    );
  }
}


