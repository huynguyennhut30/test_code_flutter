import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_sneaker/background_screen1.dart';
import 'package:g_sneaker/model/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];
  Future<void> fetchMyData() async {
    final response = await rootBundle.loadString('assets/shoes.json');
    final data = json.decode(response);
    setState(() {
      items = data["shoes"];
    });
  }

  List<Map<String, dynamic>> cartItems = [];
  List<bool> isAdded = [];
  bool isInCart = false;
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
    int index = items.indexOf(item);
    isAdded[index] = true; // Cập nhật trạng thái đã thêm sản phẩm
    isInCart = true;
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  int count = 1;
  @override
  void initState() {
    super.initState();
    fetchMyData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final mediaQuery = MediaQuery.of(context);
          final isMobile = mediaQuery.size.shortestSide < 600;

          return isMobile
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 77, left: 77),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.red,
                          ),
                          height: 600,
                          width: 360,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.red,
                          ),
                          height: 600,
                          width: 360,
                        ),
                        // Stack(
                        //   children: [
                        //     // Widget 1 for mobile
                        //     ProductListScreen()
                        //   ],
                        // ),
                        // Stack(
                        //   children: [
                        //     const Text('test1'),
                        //     CartScreen()
                        //     // Widget 2 for mobile
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // điều chỉnh vị trí đổ bóng
                            ),
                          ],
                        ),
                        height: 600,
                        width: 360,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height: 26,
                                        width: 50,
                                        child: Image.asset(
                                          'logo.png',
                                        )),
                                    // const SizedBox(
                                    //   height: 26,
                                    // ),
                                    const Text(
                                      'Our Products',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                              'Rubik-VariableFont_wght'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        left: 26, right: 26, bottom: 77),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 380,
                                          width: 304,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.grey.shade400),
                                          child: Transform.rotate(
                                            angle: -pi / 7,
                                            alignment: Alignment.center,
                                            child: Image.network(
                                                items[index]["image"]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        Text(
                                          items[index]["name"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              fontFamily:
                                                  'Rubik-VariableFont_wght'),
                                        ),
                                        const SizedBox(
                                          height: 29,
                                        ),
                                        Text(
                                          items[index]["description"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily:
                                                  'Rubik-VariableFont_wght'),
                                        ),
                                        const SizedBox(
                                          height: 23,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${items[index]["price"]}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      'Rubik-VariableFont_wght'),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addToCart(items[index]);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 46,
                                                width: 132,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Colors.yellow),
                                                child: const Text(
                                                  'ADD TO CART',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily:
                                                          'Rubik-VariableFont_wght'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // điều chỉnh vị trí đổ bóng
                            ),
                          ],
                        ),
                        height: 600,
                        width: 360,
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxHeight: 100,
                                maxWidth: double.infinity,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 26,
                                      width: 50,
                                      child: Image.asset(
                                        'logo.png',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Your Cart',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              fontFamily:
                                                  'Rubik-VariableFont_wght'),
                                        ),
                                        Text('\$0.00',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    'Rubik-VariableFont_wght')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 106,
                                        width: 106,
                                        child: Image.network(
                                            cartItems[index]["image"]),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(cartItems[index]["name"]),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(cartItems[index]["price"]
                                              .toString()),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        count--;
                                                        if (count < 1) {
                                                          removeFromCart(index);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 28,
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade400,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: SizedBox(
                                                          width: 8,
                                                          height: 8,
                                                          child: Image.asset(
                                                              'minus.png')),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Text('$count'),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        count++;
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 28,
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade400,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: SizedBox(
                                                        width: 8,
                                                        height: 8,
                                                        child: Image.asset(
                                                            'plus.png'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    removeFromCart(index),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: SizedBox(
                                                      width: 15,
                                                      height: 15,
                                                      child: Image.asset(
                                                          'trash.png')),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
