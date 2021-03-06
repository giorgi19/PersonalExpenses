import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends  StatefulWidget {

final Function addTransaction;

 NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final _titleController = TextEditingController();
final _amountController = TextEditingController();
DateTime _selectedDate;

 void _submitData(){

    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

  widget.addTransaction(
    enteredTitle,
    enteredAmount,
    _selectedDate,
  );
      Navigator.of(context).pop();                
 }

void _presenDatePicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), 
  firstDate: DateTime(2019), lastDate: DateTime.now()).then((pickedDate) {
      if(pickedDate == null)
      {
        return ;
      }
      setState(() {
     _selectedDate = pickedDate;
      });
  }
  );
}

  @override
  Widget build(BuildContext context) {
    return  Card(
                elevation: 5,          
                child: Container(
                  padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    TextField(
                     decoration: InputDecoration(labelText: 'title'),
                     controller: _titleController,
                     onSubmitted: (_) => _submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'amount'),
                      controller: _amountController,
                      keyboardType:TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    ),
                    Container(
                        height: 70,
                         child: Row(children: [
                        Expanded(
               child: Text(_selectedDate== null ? 'No Data Chosen!' : 
                          'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                        ),
                        FlatButton(
                          onPressed: _presenDatePicker,
                           child: Text('Choose Date',
                           style: TextStyle(fontWeight:FontWeight.bold ),),
                          color: Theme.of(context).primaryColor
                        ),
                      ],),
                    ),
                    RaisedButton(
                      child: Text('add Transaction'),
                      color:Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed:  _submitData, 
                    )
                  ],),
                ),
              );
  }
}