import 'package:unitedbiker/Packages/packages.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Sample list of favorite product images
  List<String> favProductImages = [
    'assets/tyres.png',
    'assets/mirrors.png',
    'assets/seats.png',
    'assets/tyres.png',
    'assets/mirrors.png',
    'assets/seats.png',
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: appBar('Favorites', false, () => null),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: favProductImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // screenFunctions.nextScreen(
                //     context, const ProductDetailScreen());
              },
              child: Container(
                height: height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(favProductImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
