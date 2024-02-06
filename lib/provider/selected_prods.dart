import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:get/get.dart';

class SelectedProdListController extends GetxController {
  RxList<Prod> prodList = <Prod>[].obs;

  void addProd(Prod prod) {
    prodList.add(prod);
    update();
  }

  void clearProds() {
    prodList.clear();
    update();
  }
}


//provider 사용

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class YourWidget extends StatelessWidget {
//   final ProdListController prodListController = Get.put(ProdListController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Example of adding a Prod to the ProdList
//                 Prod newProd = Prod(
//                   name: 'Product Name',
//                   price: '100',
//                   couponPrice: '80',
//                   rating: 4,
//                   ratingNum: 100,
//                   link: 'https://example.com',
//                 );
//                 prodListController.addProd(newProd);
//               },
//               child: Text('Add Prod'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Example of clearing all Prods from the ProdList
//                 prodListController.clearProds();
//               },
//               child: Text('Clear Prods'),
//             ),
//             Obx(() {
//               // Observe changes in the prodList and rebuild when it changes
//               return Column(
//                 children: prodListController.prodList.map((prod) {
//                   return ListTile(
//                     title: Text(prod.name),
//                     subtitle: Text(prod.price),
//                     // Add more details as needed
//                   );
//                 }).toList(),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
