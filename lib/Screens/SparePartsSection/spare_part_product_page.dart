// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter_cart/flutter_cart.dart';
import 'package:unitedbiker/Packages/packages.dart';

class SparePartProductPage extends StatefulWidget {
  SparePartProductPage(
      {Key? key,
      required this.productCategory,
      required this.companyName,
      required this.productDescription,
      required this.productPrice,
      required this.productPictures});
  String productCategory;
  String companyName;
  String productPrice;
  String productDescription;
  List<String> productPictures;
  @override
  _SparePartProductPageState createState() => _SparePartProductPageState();
}

class _SparePartProductPageState extends State<SparePartProductPage> {
  int selectedImageIndex = 0;
  late PageController _pageController;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        selectedImageIndex = _pageController.page!.round();
      });
    });
  }

  var cart = FlutterCart();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: appBar('Product Details', true, () {
        showSnackbar(context, appBarColor, 'Product is added in Favorites');
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image slider with circular dots
          SizedBox(
            height: height * 0.35,
            child: ListView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.productPictures.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.productPictures[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.productPictures.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: selectedImageIndex == i
                          ? appBarColor
                          : appBarColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
            ],
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Brand Name: ${widget.companyName}',
                  style: montserrat17,
                ),
                const SizedBox(height: 4),
                Text(
                  'Price: Pkr${widget.productPrice}',
                  style: montserrat17,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: height * 0.3,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      widget.productDescription,
                      style: montserrat12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () async {
              auth.currentUser != null
                  ? databaseFunctions.addOrder(
                      '${widget.companyName} ${widget.productCategory}',
                      1,
                      auth.currentUser!.uid,
                      context)
                  : screenFunctions.nextScreen(
                      context,
                      AuthScreen(
                        fromProductPage: false,
                      ));
            },
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Order Now',
                    style: montserratWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
