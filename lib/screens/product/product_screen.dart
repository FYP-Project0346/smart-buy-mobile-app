import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartbuy/generate_route.dart';
import 'package:smartbuy/models/product_model.dart';
import 'package:smartbuy/services/product_service.dart';
import '../../constants.dart';
import '../../general.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductModel product;
  bool isSubscribed = false;

  @override
  void initState() {
    product = widget.product;
    super.initState();
    if(ProjectData.user != null){
      ProductService().verifySubscription(product.id).then((value) => setState(() {
        isSubscribed = value;
      }));
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: SingleChildScrollView(
          child: Column(
            children: [
              General.showProductImage(product.images[0]),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontSize: 24),
                    ),
                    Row(
                      children: General.getRatingStar(product.rating, size: 24),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      product.desc,
                      style: TextStyle(fontSize: 16),
                      maxLines: 1000,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 8),
          ElevatedButton(
              onPressed: ProjectData.user == null ? null : handleSubscription,
              child: isSubscribed ? const Text("Unsubscribe") : const Text("Subscribe")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, RouteGenerator.generateRoute(context, RouteSettings(name: Routes.productOnSite, arguments: Uri.parse(product.url))));

          }, child: Text("Purchase")),
        ],
      ),
    );
  }



  void handleSubscription() async {
    if (isSubscribed){
      var response = await ProductService().unsubscribe(product.id);
      if (response){
        Fluttertoast.showToast(msg: "Unsubscribed Successfully");
        setState(() {
          isSubscribed = false;
        });
      }
    }else{
      var response = await ProductService().subscribe(product.id);
      if (response){
        Fluttertoast.showToast(msg: "Subscribed Successfully");
        setState(() {
          isSubscribed = true;
        });
      }
    }
  }
}
