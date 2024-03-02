import 'package:unitedbiker/Packages/packages.dart';
import 'package:unitedbiker/Screens/SparePartsSection/spare_part_product_page.dart';

class SparePartsScreen extends StatefulWidget {
  SparePartsScreen({super.key, required this.productCategory});
  String productCategory;

  @override
  State<SparePartsScreen> createState() => _SparePartsScreenState();
}

class _SparePartsScreenState extends State<SparePartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          widget.productCategory == 'tyres'
              ? 'Tyres'
              : widget.productCategory == 'mirrors'
                  ? 'Mirrors'
                  : widget.productCategory == 'silencers'
                      ? 'Silencers'
                      : widget.productCategory == 'footrest'
                          ? 'Foot Rest'
                          : 'Seats',
          false,
          () => null),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.productCategory)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No bikes available'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  2, // You can adjust the number of columns as needed
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Existing code for fetching bike data
              var bikeData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String companyName = bikeData['company'] ?? '';
              String contact = bikeData['contact'] ?? '';
              String productDescription = bikeData['description'] ?? '';
              String productPrice = bikeData['price'] ?? '';
              List<String> imageUrls =
                  List<String>.from(bikeData['productPictures'] ?? []);
              return GestureDetector(
                onTap: () {
                  screenFunctions.nextScreen(
                      context,
                      SparePartProductPage(
                        companyName: companyName,
                        productCategory: widget.productCategory,
                        productDescription: productDescription,
                        productPrice: productPrice,
                        productPictures: imageUrls,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
                  child: GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appBarColor,
                        image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              imageUrls.isNotEmpty ? imageUrls[0] : ''),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryPrimaryColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                companyName,
                                style: montserratBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // You can add more content or functionality if needed
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
