import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (_, index) => OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
