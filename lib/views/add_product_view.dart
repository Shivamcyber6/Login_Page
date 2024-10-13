import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/product_view_model.dart';

class AddProductPage extends StatelessWidget {
  final ProductViewModel viewModel = ProductViewModel();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add the product and handle potential errors
                String? error = await viewModel.addProduct(
                    nameController.text, priceController.text);

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error!)));
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
