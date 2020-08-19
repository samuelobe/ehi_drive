// import 'package:flutter/material.dart';

// class LoginTextField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextFormField(
//         maxLength: 10,
//         decoration: InputDecoration(
//           filled: true,
//           prefixIcon: Icon(
//             Icons.person,
//           ),
//           labelStyle: TextStyle(fontSize: 14),
//           labelText: "Username",
//           counterText: "",
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: BorderSide(),
//           ),
//         ),
//         keyboardType: TextInputType.text,
//         validator: (input) {
//           var output;
//           if (input.isEmpty) {
//             output = "Please type in your username";
//           }
//           return output;
//         },
//         onSaved: (input) => username = input.trim(),
//       ),
//     );
//   }
// }
