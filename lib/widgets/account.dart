import 'package:flutter/material.dart';

class Account extends StatelessWidget{
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 300,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Dimenzio'),
              ),
              IconButton(
                onPressed: () {
                  
                },
                 icon: Icon(Icons.delete)
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}