// import 'package:flutter/material.dart';

// class GridItem extends StatelessWidget {
//   final IconData icon;
//   final String categoria;

//   const GridItem(
//     this.icon,
//     this.categoria,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: <Widget>[
//           TextField(
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.all(15.0),
//               hintText: 'Procure por nome, descrição ou código de barras',
//             ),
//             onChanged: (string) {
//               _debouncer.run(
//                 () {
//                   setState(
//                     () {
//                       filteredProdutos = produtos
//                           .where(
//                             (produto) => (produto.nome
//                                     .toLowerCase()
//                                     .contains(string.toLowerCase()) ||
//                                 produto.descricao
//                                     .toLowerCase()
//                                     .contains(string.toLowerCase()) ||
//                                 produto.codigoDeBarra.toLowerCase().contains(
//                                       string.toLowerCase(),
//                                     )),
//                           )
//                           .toList();
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(10.0),
//               itemCount: filteredProdutos.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Row(
//                       children: <Widget>[
//                         Image.network(filteredProdutos[index].image, scale: 5),
//                         SizedBox(width: 5,),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               filteredProdutos[index].nome,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Text(
//                               filteredProdutos[index].descricao.toLowerCase(),
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               FlatButton(
//                                 padding: EdgeInsets.only(left: 40),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => FloatPage(
//                                       "Cadastrar produto",
//                                       "Nome",
//                                       "Valor",
//                                       "Descrição",
//                                       1,
//                                       10,
//                                     ),
//                                   );
//                                 },
//                                 child: Icon(
//                                   Icons.edit,
//                                   size: 20,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text("Valor", style: TextStyle(fontWeight: FontWeight.bold),),
//                               Text("${filteredProdutos[index].valor}")
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],);
//       }
// }
