import 'package:flutter/material.dart';
import 'package:personalexpanses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends  StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;
  TransactionList({this.transaction,this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 400,
          child: transaction.isEmpty  ?
          Column(children: [
            Text('No Transactions added',
            style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height:20),
            Container(
              height: 200,
               child: Icon(Icons.warning),//Image.asset('assets/images/waiting.png',
             // fit: BoxFit.cover,
              ),
            
          ],) :
            ListView.builder(
            itemBuilder: (ctx,index){
                 return Card(
                        child:Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical:10,horizontal:10),
                              decoration: BoxDecoration(border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                              padding: EdgeInsets.all(10),
                              child: Text('\$${transaction[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20,
                                   color: Theme.of(context).primaryColor,
                                 ),
                              )
                            ),
                            Flexible(

                              fit: FlexFit.tight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(transaction[index].title,
                                   style: Theme.of(context).textTheme.title,
                                   ),
                                   Text(
                                     DateFormat.yMMMd().format( transaction[index].date),                     
                                   style: TextStyle(color: Colors.grey,
                                   )),
                                  
                              ],),
                            ),
                             IconButton(
                                    onPressed:() => deleteTransaction(transaction [index].id ),
                                   icon: Icon(Icons.delete),
                                   color: Colors.red,
                                   ),
                          ],
                        )
                      );
            },
            itemCount: transaction.length,
            scrollDirection: Axis.vertical,
    )
    );
  }
}