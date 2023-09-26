import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List App'),
        ),
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product('Product 1', 10),
    Product('Product 2', 15),
    Product('Product 3', 20),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          subtitle: Text('Price: \$${products[index].price}'),
          trailing: ProductCounter(product: products[index]),
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int quantity = 0;

  Product(this.name, this.price);
}

class ProductCounter extends StatefulWidget {
  final Product product;

  ProductCounter({required this.product});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Quantity: ${widget.product.quantity}'),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.product.quantity++;
              if (widget.product.quantity == 5) {
                _showCongratulationsDialog(widget.product.name);
              }
            });
          },
          child: Text('Buy Now'),
        ),
      ],
    );
  }

  void _showCongratulationsDialog(String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 $productName!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
