import 'package:flutter/material.dart';
import 'package:personalexpanses/widgets/chart.dart';
import 'package:personalexpanses/widgets/new_transaction.dart';
import 'package:personalexpanses/models/transaction.dart';
import 'package:personalexpanses/widgets/transaction_list.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
        title:TextStyle(
          fontSize:18,
          fontWeight:FontWeight.bold
        )
        ),
        appBarTheme: AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontSize:20,
              fontWeight:FontWeight.bold
            ),
            button: TextStyle(color: Colors.white)
          ),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<Transaction> transaction = [
      // Transaction(id: 'id1',title: 'title1',amount: 99.99,date: DateTime.now()),
      // Transaction(id: 'id2',title: 'title2',amount: 99.99,date: DateTime.now()),
      ];

List<Transaction> get _recentTransaction {
  return transaction.where((tx){
    return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
  
}

  void _addTransaction(String txTitle,double amount,DateTime chosenDate){
    final newTx = Transaction(
      amount: amount,title:txTitle,
    date: chosenDate,
    id: DateTime.now().toString());
setState(() {
  transaction.add(newTx);
});
  }
void startAddNewTransaction(BuildContext ctx) {
  showModalBottomSheet(
  context: ctx, 
  builder: (_){
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: NewTransaction(addTransaction:_addTransaction));
  });
}
void _deleteTransaction(String id){
setState(() {
  transaction.removeWhere((element) => element.id == id);
});
}

  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
        appBar: AppBar(
          title:Text('Flutter App'),
          actions: [
            IconButton(icon:Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
            )
          ],
          ),
          body: SingleChildScrollView(
                 child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Chart(recentTransaction:_recentTransaction),    
                // UserTransaction()
               //  NewTransaction(addTransaction:_addTransaction),
                 TransactionList(transaction:transaction,deleteTransaction: _deleteTransaction,),
            ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
              onPressed: () =>
          startAddNewTransaction(context),
          )
      );
  }
}