import 'package:axon_launcher/api/account_api.dart';
import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/launcher_state.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    this.isSelected = false,
    required this.account
  });

  final bool isSelected;
  final Account account;

  @override
  Widget build(BuildContext context) {
    final userId = account.userId;
    final userName = account.userName;
    final theme = Theme.of(context);
    final textEditingController = TextEditingController();
    textEditingController.text = userName;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 400,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  if(isSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('This account is already selected')));
                    return;
                  }
                    final state = LauncherState.singleton;
                    if(accountFile == null || state == null) return;
                    //Move the already existing user.json into the account directory if one exists
                    if(state.currentAccount != null) {
                      final newPath = await getNewAccountPath(state.currentAccount!.userName);
                      if(newPath == null) return;
                      await accountFile!.rename(newPath);
                    }
                    //Move the account to the root of the Axon Directory for the client to be used
                    await account.file.rename(accountFile!.path);
                    state.readAccounts();
                },
                icon: Icon(Icons.check)
              ),
              //User Icon with UserId copy function
              Tooltip(
                  waitDuration: Duration(milliseconds: 500),
                  message: userId,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      if(userId != 'pending') {
                        Clipboard.setData(ClipboardData(text: userId));
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(userId == 'pending' ? 'The UserId of this account isn\'t generated yet.\nPlease start the client once with this account to generate a userId' : 'Copied userID $userId to clipboard')));
                    },
                  )),
              //Username
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 8,
                ),
                child: SizedBox(
                  height: 30,
                  width: 200,
                  child: TextFormField(
                    controller: textEditingController,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      height: 2,
                    ),
                    cursorColor: theme.colorScheme.onPrimary,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Username',
                        constraints: BoxConstraints(maxWidth: 800)),
                  ),
                ),
              ),
              //Save new Username Button
              IconButton(
                onPressed: () {
                  account.userName = textEditingController.text;
                  account.saveToFile();
                },
                icon: Icon(Icons.save),
              ),
              //Delete Button
              IconButton(
                  onPressed: () async {
                    var confirmed = await _showDeleteDialog(context);
                    if (confirmed) {
                      print('Delete Account');
                      await account.file.delete();
                      await LauncherState.singleton!.readAccounts();
                    }
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteDialog(BuildContext context) async {
    var style = primaryTextStyle;
    var success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'You are about to delete your Account\nThis can\'t be undone!\nAre you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Delete',
                style: style,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: style,
              ),
            ),
          ],
        );
      },
    );
    return success!;
  }
}
