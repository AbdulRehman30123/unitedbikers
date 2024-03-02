// ignore_for_file: use_key_in_widget_constructors

import 'package:unitedbiker/Packages/packages.dart';

class BikeDetailScreen extends StatefulWidget {
  BikeDetailScreen(
      {Key? key,
      required this.modelName,
      required this.productDescription,
      required this.productPrice,
      required this.usedBike,
      required this.contact,
      required this.yearsUsed,
      required this.bikesPicture});
  String productPrice;
  String productDescription;
  String modelName;
  bool usedBike;
  // fields for used bikes
  String contact;
  String yearsUsed;
  List<String> bikesPicture;

  @override
  _BikeDetailScreenState createState() => _BikeDetailScreenState();
}

class _BikeDetailScreenState extends State<BikeDetailScreen> {
  int selectedImageIndex = 0;

  late PageController _pageController;
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
              itemCount: widget.bikesPicture.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.bikesPicture[index],
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
              for (int i = 0; i < widget.bikesPicture.length; i++)
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
                  'Brand Name: ${widget.modelName}',
                  style: montserrat17,
                ),
                const SizedBox(height: 4),
                Text(
                  'Price: Pkr${widget.productPrice}',
                  style: montserrat17,
                ),
                const SizedBox(height: 4),
                widget.usedBike
                    ? Text(
                        'Condition: ${widget.yearsUsed} used',
                        style: montserrat12,
                      )
                    : Container(),
                widget.usedBike ? const SizedBox(height: 4) : Container(),
                SizedBox(
                  height: widget.usedBike ? height * 0.22 : height * 0.23,
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
            onTap: () {
              screenFunctions.openWhatsAppChat(widget.contact);
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
                    'Contact Seller',
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
