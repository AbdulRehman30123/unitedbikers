import 'package:intl/intl.dart';
import 'package:unitedbiker/Packages/packages.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('My Orders', false, () => null),
      body: FutureBuilder(
        future: databaseFunctions.getUserOrders(auth.currentUser!.uid),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No orders available for the user.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var order = snapshot.data![index];
                var orderName = order['productName'];
                var quantity = order['quantity'];
                var orderId = order['orderId'];

                // Extracting only the date part from the timestamp
                var orderTime = order['orderTime'];
                var formattedDate = DateFormat('MMMM d, yyyy').format(
                    orderTime.toDate()); // Assuming orderTime is a Timestamp

                return orderContainer(
                    orderName, quantity, formattedDate, orderId);
              },
            );
          }
        },
      ),
    );
  }

  orderContainer(
      String productName, int quantity, String orderTime, String orderId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product: $productName',
                style: montserratWhite,
              ),
              Text(
                'Quantity: $quantity',
                style: montserratWhite,
              ),
              Text(
                'Order Day: $orderTime',
                style: montserratWhite2,
              ),
              Text(
                'Order Id: $orderId',
                style: montserratWhite2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
