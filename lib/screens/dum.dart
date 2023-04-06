// import 'package:flutter/material.dart';
// import '../providers/product.dart';
// import '../providers/products.dart';
// import 'package:provider/provider.dart';

// class EditProductScreen extends StatefulWidget {
//   static const routeName = '/edit-product';
//   @override
//   State<EditProductScreen> createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _descriptionFocusNode = FocusNode();
//   final _priceFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct = Product(
//     description: '',
//     id: null,
//     imageUrl: '',
//     price: 0,
//     title: '',
//   );
//   var _isInit = true;
//   var _initValues = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': '',
//   };

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context)!.settings.arguments as String;
//       if (productId != null) {
//         _editedProduct =
//             Provider.of<Products>(context, listen: false).findById(productId);
//         _initValues = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'price': _editedProduct.price.toString(),
          
//           'imageUrl': '',
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }

//   void _saveForm() {
//     final isValid = _form.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Edit Product',
//         ),
//         actions: [
//           IconButton(
//             onPressed: _saveForm,
//             icon: Icon(
//               Icons.save,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//             key: _form,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   initialValue: _initValues['title'],
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_priceFocusNode);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please provide a value';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         description: _editedProduct.description,
//                         id: null,
//                         imageUrl: _editedProduct.imageUrl,
//                         price: _editedProduct.price,
//                         title: value as String);
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValues['price'],
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   focusNode: _priceFocusNode,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a price';
//                     }
//                     if (double.tryParse(value as String) == null) {
//                       return 'Please enter a valid number';
//                     }
//                     if (double.parse(value) <= 0) {
//                       return 'Please enter a number greater than zero';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         description: _editedProduct.description,
//                         id: null,
//                         imageUrl: _editedProduct.imageUrl,
//                         price: double.parse(value as String),
//                         title: _editedProduct.title);
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _initValues['description'],
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a description';
//                     }
//                     if (value.length < 10) {
//                       return 'Should be at least 10 characters long';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.multiline,
//                   focusNode: _descriptionFocusNode,
//                   onSaved: (value) {
//                     _editedProduct = Product(
//                         description: value as String,
//                         id: null,
//                         imageUrl: _editedProduct.imageUrl,
//                         price: _editedProduct.price,
//                         title: _editedProduct.title);
//                   },
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       margin: EdgeInsets.only(
//                         top: 8,
//                         right: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       child: _imageUrlController.text.isEmpty
//                           ? Text('Enter a URL')
//                           : FittedBox(
//                               child: Image.network(
//                                 _imageUrlController.text,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         initialValue: _initValues['imageUrl'],
//                         decoration: InputDecoration(labelText: 'Image URL'),
//                         keyboardType: TextInputType.url,
//                         textInputAction: TextInputAction.done,
//                         controller: _imageUrlController,
//                         focusNode: _imageUrlFocusNode,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter an image URL';
//                           }
//                           if (value.startsWith('http') &&
//                               !value.startsWith('https')) {
//                             return 'Please enter a valid URL';
//                           }
//                           if (!value.endsWith('.png') &&
//                               !value.endsWith('.jpg') &&
//                               !value.endsWith('.jpeg')) {
//                             return 'Please enter a valid image URL, (Jpeg, jpg ,png)';
//                           }
//                           return null;
//                         },
//                         onFieldSubmitted: (_) {
//                           _saveForm();
//                         },
//                         onSaved: (value) {
//                           _editedProduct = Product(
//                             description: _editedProduct.description,
//                             id: null,
//                             imageUrl: value as String,
//                             price: _editedProduct.price,
//                             title: _editedProduct.title,
//                           );
//                         },
//                         onEditingComplete: () {
//                           setState(() {});
//                         },
//                         onTapOutside: (_) {
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
