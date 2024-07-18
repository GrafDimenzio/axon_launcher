import 'dart:io';

import 'package:axon_launcher/api/account_api.dart';
import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/states/account_state.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:axon_launcher/widgets/account_widget.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({
    super.key,
  });

  static const double addButtonSize = 80;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = AccountState.singleton;

    return ListenableBuilder(
      listenable: state,
      builder: (context, child) {
        return Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Selected Account:',
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  state.currentAccount == null ? Text('No Account selected') : AccountWidget(account: state.currentAccount!, isSelected: true,),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Other Accounts:',
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  for(var acc in state.accounts)
                    AccountWidget(account: acc),
                ],
              ),
            ),
          ),
          //Add Account Button
          Positioned(
            right: 16,
            bottom: 16,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Container(
              height: addButtonSize,
              width: addButtonSize,
              color: theme.colorScheme.surfaceContainer,
              child: IconButton(
                iconSize: 50,
                icon: Icon(Icons.add),
                onPressed: () {
                  _showAccountDialog(context, state);
                },
              ),
            ),
          )
          ),
          
        ],
      );
      },
    );
  }

  Future<void> _showAccountDialog(BuildContext context, AccountState state) {
    final textEditingController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Create a new Account'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Name'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if(textEditingController.text.isEmpty) return;

                final path = state.currentAccount == null ? accountFile!.path : await getNewAccountPath(textEditingController.text);
                if(path == null) return;

                var acc = Account(userName: textEditingController.text, identity: 'pending', file: File(path));
                await acc.saveToFile();
                await state.readAccounts();
                print('CREATE ACCOUNT ${textEditingController.text}');
              },
              child: Text('Create'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')
            ),
          ],
        );
      },
    );
  }
}
