import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartbuy/constants.dart';
import 'package:smartbuy/generate_route.dart';
import 'package:smartbuy/services/product_service.dart';
import 'package:smartbuy/xutils/xtextfield.dart';
import '../../general.dart';
import '../../models/product_model.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool searchMood = false;
  var searchCont = TextEditingController();
  int limit = 16;

  void toggleSearch() {
    setState(() {
      searchMood = !searchMood;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color.fromRGBO(255, 250, 250, 0.9);

    return Scaffold(

      backgroundColor: bgColor,

      appBar: searchMood
          ? AppBar(
        backgroundColor: bgColor,
              title: Row(
                children: [
                  GestureDetector(
                      onTap: toggleSearch,
                      child: const Icon(Icons.arrow_back_ios_new_outlined)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: XTextField(
                      controller: searchCont,
                      hint: "Search Item",
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            searchCont.text = "";
                          });
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: (){setState(() {});},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),

                        child: const Text("Search", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          fontSize: 17
                        ),
                        )
                    ),
                  )
                ],
              ),
            )
          : AppBar(
        backgroundColor: bgColor,
              title: const Text("SmartBuy"),
              actions: [
                ProjectData.user == null ?
                TextButton(onPressed: (){
                  Navigator.push(context, RouteGenerator.generateRoute(context, const RouteSettings(name: Routes.login)));
                }, child: const Text("Login",style: TextStyle(color: Colors.black),)) : const SizedBox.shrink(),
                // TextButton(onPressed: (){
                //   Navigator.push(context, RouteGenerator.generateRoute(context, const RouteSettings(name: Routes.register)));
                // }, child: const Text("Register")),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: toggleSearch,
                  child: const Icon(Icons.search),
                ),
                const SizedBox(width: 20),
              ],
            ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ProductService().getProducts(search: searchCont.text, limit: limit.toString()),
          builder: (_, AsyncSnapshot snap) {
            if (snap.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: Stack(
                        children: [
                      Image.asset(ProjectPaths.heroImage, fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height
                          ,),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    children: List.generate(snap.data.length+1, (index) {
                      if(index == snap.data.length){
                        return Column(
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    limit += 16;
                                  });
                                }, child: const Text("More")),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ) ;
                      }


                      var product = ProductModel.fromMap(snap.data[index]);
                      return CardWidget(product);
                    }),
                  ),
                ],
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void navigateToProductPage(ProductModel product) {
    Navigator.push(
        context,
        RouteGenerator.generateRoute(
            context, RouteSettings(name: Routes.product, arguments: product)));
  }

  Widget CardWidget(ProductModel product) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: GestureDetector(
        onTap: (){
          navigateToProductPage(product);
        },
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              General.showProductImage(product.images[0] ?? "", height: 200),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 17),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Site: ${product.site}",
                      style: const TextStyle(fontSize: 13),
                    ),
                    Row(
                      children: General.getRatingStar(3),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
