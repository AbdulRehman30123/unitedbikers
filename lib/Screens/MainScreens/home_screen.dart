import 'package:unitedbiker/Packages/packages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List firstSliderImages = [
    'assets/tyres.png',
    'assets/mirrors.png',
    'assets/seats.png'
  ];
  List firstSliderTags = ['Tyres', 'Mirrors', 'Seats'];
  List secondSliderImages = ['assets/footrest.jpg', 'assets/silencer.png'];

  List secondSliderTags = ['Foot Rest', 'Silencers'];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: homeScreenColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text line
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              child: SizedBox(
                width: width * 0.7,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Let us help you to',
                        style: montserratWhite,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'find',
                              style: montserratWhite,
                            ),
                            TextSpan(
                              text: ' Perfect Bike',
                              style: montserratBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                bikeCategoryContainer(() {
                  setState(() {
                    bikeCategory = 'usedbikes';
                  });
                  screenFunctions.nextScreen(
                    context,
                    BikeSectionScreen(
                      bikeCategory: bikeCategory,
                    ),
                  );
                }, 'Used Bikes'),
                bikeCategoryContainer(() {
                  setState(() {
                    bikeCategory = 'newbikes';
                    screenFunctions.nextScreen(
                      context,
                      BikeSectionScreen(
                        bikeCategory: bikeCategory,
                      ),
                    );
                  });
                }, 'New Bikes'),
                bikeCategoryContainer(() {
                  setState(() {
                    bikeCategory = 'popularbikes';
                  });
                  screenFunctions.nextScreen(
                    context,
                    BikeSectionScreen(
                      bikeCategory: bikeCategory,
                    ),
                  );
                }, 'Popular Bikes'),
              ],
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryPrimaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      // first slider
                      SizedBox(
                        height: height * 0.4, // Adjust the height as needed
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: firstSliderImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  screenFunctions.nextScreen(
                                      context,
                                      SparePartsScreen(
                                        productCategory: index == 0
                                            ? 'tyres'
                                            : index == 1
                                                ? 'mirrors'
                                                : 'seats',
                                      ));
                                },
                                child: Container(
                                  height: height * 0.3,
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      filterQuality: FilterQuality.high,
                                      image: AssetImage(
                                        firstSliderImages[index],
                                      ),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, left: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: secondaryPrimaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            firstSliderTags[index],
                                            style: montserratBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // second slider
                      SizedBox(
                        height: height * 0.23, // Adjust the height as needed
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: secondSliderImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                screenFunctions.nextScreen(
                                    context,
                                    SparePartsScreen(
                                      productCategory:
                                          index == 0 ? 'footrest' : 'silencers',
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        filterQuality: FilterQuality.high,
                                        image: AssetImage(
                                          secondSliderImages[index],
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, left: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: secondaryPrimaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            secondSliderTags[index],
                                            style: montserratBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

bikeCategoryContainer(Function()? onTap, String buttonTitle) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonTitle,
            style: montserrat12,
          ),
        ),
      ),
    ),
  );
}
