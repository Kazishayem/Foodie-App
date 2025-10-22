import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:foodie_app/pages/cart.dart';
import 'package:foodie_app/widgets/CategoryFoods.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //row 1
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Foodie",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lobster',
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Order your favourite food!",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'Poppins',
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),

                    CircleAvatar(child: Image.asset("assets/images/man.jpg")),

                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Cart()),
                    //     );
                    //   },
                    //   icon: Icon(
                    //     Icons.shopping_cart,
                    //     color: AppColors.primary,
                    //     size: 35,
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.black),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w200,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  children: [
                    Container(width: 370, height: 600, child: CategoryFoods()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
