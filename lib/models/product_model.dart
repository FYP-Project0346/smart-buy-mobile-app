class ProductFields {
  String productId = "_id";
  String url = "product_url";
  String title = "title";
  String price = "price";
  String stock = "stock";
  String desc = "desc";
  String images = "images";
  String rating = "ratings";
  String site = "site";
  String category = "category";
}

class ProductModel {
  String id;
  String url;
  String title;
  int price;
  bool stock;
  String desc;
  List images;
  int rating;
  String site;
  String category;
  ProductModel({
    required this.id,
    required this.url,
    required this.title,
    required this.price,
    required this.stock,
    required this.desc,
    required this.images,
    required this.rating,
    required this.site,
    required this.category,
  });

  factory ProductModel.fromMap(Map data) {
    var f = ProductFields();
    return ProductModel(
        id: data[f.productId],
        url: data[f.url],
        title: data[f.title],
        price: data[f.price],
        stock: data[f.stock],
        desc: data[f.desc],
        images: data[f.images],
        rating: data[f.rating],
        site: data[f.site],
        category: data[f.category]);
  }
}
