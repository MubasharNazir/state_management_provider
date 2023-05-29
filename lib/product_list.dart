//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:state_management_provider/cart_model.dart';
import 'package:state_management_provider/cart_provider.dart';
import 'package:state_management_provider/cart_screen.dart';
import 'package:state_management_provider/db_helper.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'MixedFruit'
  ];
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'Dozen', 'KG', 'KG', 'Kg'];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://thumbs.dreamstime.com/b/single-mango-fruit-isolated-white-background-fresh-single-mango-fruit-isolated-white-background-167545028.jpg',
    'https://img.freepik.com/premium-photo/single-orange-fruit-isolated-white-healthy-food_194646-1704.jpg?w=2000',
    'https://www.pngkey.com/png/detail/393-3936134_report-abuse-single-fruits-and-vegetables.png',
    'https://us.123rf.com/450wm/cepn/cepn2009/cepn200900020/155940267-fresh-banana-isolated-bunch-of-ripe-organic-bananas-on-white-background.jpg?ver=6',
    'https://www.shutterstock.com/image-photo/group-red-dark-cherries-green-260nw-1781252894.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNP4Bn5r5zwWaqQFLOLde2lxGOE1IQQuyh2A&usqp=CAU',
    'https://thumbs.dreamstime.com/b/colorful-fruit-mix-fruits-close-up-image-isolated-white-background-31297821.jpg'
  ];
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                badgeAnimation: badges.BadgeAnimation.rotation(
                  animationDuration: Duration(microseconds: 300),
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productName.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                    height: 100,
                                    width: 100,
                                    image: NetworkImage(
                                        productImage[index].toString())),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        productUnit[index].toString() +
                                            '   ' +
                                            r'$' +
                                            productPrice[index].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            print(index);
                                            print(index);
                                            print(
                                                productName[index].toString());
                                            print(
                                                productPrice[index].toString());
                                            print(productPrice[index]);
                                            print('1');
                                            print(
                                                productUnit[index].toString());
                                            print(
                                                productImage[index].toString());
                                            dbHelper!
                                                .insert(
                                              Cart(
                                                  id: index,
                                                  productId: index.toString(),
                                                  productName:
                                                      productName[index]
                                                          .toString(),
                                                  initialPrice:
                                                      productPrice[index],
                                                  productPrice:
                                                      productPrice[index],
                                                  quantity: 1,
                                                  unitTag: productUnit[index]
                                                      .toString(),
                                                  image: productImage[index]
                                                      .toString()),
                                            )
                                                .then((value) {
                                              print('add successfully');
                                              cart.addTotalPrice(double.parse(
                                                  productPrice[index]
                                                      .toString()));

                                              cart.addCounter();

                                              final snackBar = SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Product is added to cart'),
                                                duration: Duration(seconds: 1),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                                child: Text(
                                              'Add to Card',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
