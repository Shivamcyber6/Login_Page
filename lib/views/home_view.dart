import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/product_view_model.dart';
import 'package:flutter_application_1/views/add_product_view.dart';

class HomePage extends StatelessWidget {
  final ProductViewModel viewModel = ProductViewModel();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: 'Search Products'),
          onChanged: viewModel.searchProducts,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                viewModel.logout;
              })
        ],
      ),
      body: FutureBuilder(
        future: viewModel.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.products.isEmpty) {
            return const Center(child: Text('No Products Found'));
          } else {
            return ListView.builder(
              itemCount: viewModel.filteredProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(viewModel.filteredProducts[index].name),
                  subtitle: Text(viewModel.filteredProducts[index].price),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => viewModel.deleteProduct(index),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
