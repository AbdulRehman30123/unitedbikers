import 'package:unitedbiker/Packages/packages.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Map<String, dynamic> weatherData;
  bool fetching = false;
  bool fetching1 = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: secondaryPrimaryColor,
      appBar: appBar('Weather Updates', false, () => null),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
              color: secondaryPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: height * 0.4,
            child: Column(children: [
              Expanded(
                child: Container(
                  child: fetching
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'City name : ${weatherData['name']}',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xff607D8B),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              Text(
                                'Status : ${weatherData['weather'][0]['main']}',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                'Time Period : 4 Hours',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              Text(
                                'Temperature : ${weatherData['main']['temp']}K',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              Text(
                                'Note:  check weather again before going out just in case of your own health',
                                style: GoogleFonts.montserrat(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: fetching1
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                )
                              : const SizedBox()),
                ),
              ),
              customTextField('Enter Area ...', weatherController, () {
                weatherController.text.isEmpty
                    ? showSnackbar(
                        context, Colors.red, 'Please enter area name')
                    : gettingData();
              }, true)
            ]),
          ),
        ),
      ),
    );
  }

  gettingData() async {
    print(weatherController.text);
    setState(() {
      fetching = false;
      fetching1 = true;
    });
    weatherData = await weatherFunction.getWeatherData(weatherController.text);
    weatherController.clear();
    print(weatherData);
    setState(() {
      fetching = true;
      fetching1 = false;
    });
  }
}
