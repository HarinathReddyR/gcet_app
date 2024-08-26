// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill hide Text;

// class BlogPage extends StatefulWidget {
//   const BlogPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<BlogPage> createState() => BlogPageState();
// }

// class BlogPageState extends State<BlogPage> {
//   @override
//   Widget build(BuildContext context) {
//     final quill.QuillController controller = quill.QuillController.basic();
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Quill Editor'),
//         ),
//         // Quill Editor
//         body: Column(
//           children: [
//             quill.QuillToolbar.basic(controller: controller),
//             quill.QuillEditor(
//               // padding
//               padding: const EdgeInsets.all(8),
//               // Pass the controller here
//               controller: controller,
//               // if you want to control the scroll define a
//               // scroll controller and pass it here
//               scrollController: ScrollController(),
//               // set true if you want the editor to be scrollable
//               // when the keyboard appears or too much content
//               scrollable: true,
//               // pass a focus node if you want to control
//               // when the keyboard appears
//               focusNode: FocusNode(),
//               // if true the keyboard will appear
//               // when the widget is rendered
//               autoFocus: false,
//               // set true if you want to disable editing
//               readOnly: false,
//               // set true if you want the editor to expand and
//               // occupy all the available space
//               expands: false,
//               // if there is no content this
//               // text will be displayed
//               placeholder: 'Add your data here...',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
