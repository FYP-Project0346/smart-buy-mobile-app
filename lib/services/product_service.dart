import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:smartbuy/constants.dart';
class ProductService{
  Future<dynamic> getProducts({String search = "", String limit = "16"}) async {
    var params = {
      "limit": limit,
      "max": "0",
      "min": "0",
      "skip": "0",
      "sites": [],
      "search": search,
    };

    var url = Uri.parse(APIs.getProductsApi).replace(queryParameters: params);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // log('Response body: $responseBody');
      return responseBody["data"];
    } else {
      log('Failed to fetch products. Error: ${response.body}');
      return [];
    }
  }


  Future<bool> subscribe(String productId)async{
    if (ProjectData.user == null){
      throw Exception("Can't find user");
    }
    var url = Uri.parse(APIs.productSubscribeApi);
    var response = await http.post(url, body: {
      "customer_id": ProjectData.user!.id,
      "product_id": productId,
    });

    var decoded = jsonDecode(response.body);
    return decoded["msg"] == "subscribed";
  }


  Future<bool> unsubscribe(String productId)async{
    if (ProjectData.user == null){
      throw Exception("Can't find user");
    }
    Map<String, dynamic> params = {
      "customer_id": ProjectData.user!.id,
      "product_id": productId,
    };

    var url = Uri.parse(APIs.productUnsubscribeApi).replace(queryParameters: params);
    var response = await http.delete(url);
    log("msg: $response");
    var decoded = jsonDecode(response.body);

    return decoded["msg"] == "unsubscribed";
  }

  Future<bool> verifySubscription(String productId)async{
    if (ProjectData.user == null){
      throw Exception("Can't find user");
    }
    Map<String, dynamic> params = {
      "customer_id": ProjectData.user!.id,
      "product_id": productId,
    };

    var url = Uri.parse(APIs.productSubscriptionVerifyApi).replace(queryParameters: params);
    var response = await http.get(url);

    if(response.statusCode == 200){
      var decoded = jsonDecode(response.body);
      return decoded["subscribed"] == "subscribed";
    }else{
      log("status Code: ${response.statusCode}");
      throw Exception("Error while verifying subscription");
    }
  }
}