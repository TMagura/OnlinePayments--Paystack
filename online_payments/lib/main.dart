import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//create variable that will be used for state managing
var selectedIndex = null;
var price = null;
String email= "testpaystack@mailinator.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //choosing plans
            Container(
              alignment: Alignment.center,
              child: Text(
                "Products",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // GridView
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                    children: List.generate(products.length, (index){
                      final product = products[index];
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex=index;
                            price = product["price"];
                            print("index = ${selectedIndex} and price is ${price}");
                          });
                        },
                        child: Card(
                          shadowColor: Colors.amber,
                          elevation: 5, 
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: selectedIndex == null ? null : selectedIndex== index ? Colors.amber: null
                            ),
                            child: Column(
                              children: [
                                Text("${product["name"]}",
                                style: TextStyle(fontSize: 30),),
                                SizedBox(height: 5,),
                                Text("Price : ${product["price"]}"),
                                SizedBox(height: 5,),
                                Text("Description : ${product["description"]}"),
                              ],
                            ),
                          ),
                        ),
                      );
                      }),
              ),
            ),
            GestureDetector(
            onTap: () {
              if(selectedIndex==null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Add something to cart")),);
              }else{
                //call the paystack payment
                print(price);
              }
            },
            child: Container(
              alignment: Alignment.center, 
              width: MediaQuery.of(context).size.width, 
              padding: EdgeInsets.all(15), 
              decoration: BoxDecoration(color: Colors.green),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security_rounded),
                  SizedBox(width: 5,),
                  Text("Proceed to Checkout", style: TextStyle(fontSize: 30),),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  final products = [
    {"name": "lemons", "price": 1.70, "description": "on promotion"},
    {"name": "Oranges", "price": 6.00, "description": "on sale"},
    {"name": "Apples", "price": 1.00, "description": "on promotion"},
    {"name": "banana", "price": 3.70, "description": "on promotion"}
  ];
}
