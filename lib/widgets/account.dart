import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    const userId = 'Brq2boCf89mNfV9463Cwb7U7pMvivfr3DcA6QFQRXf9u@axon';
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 400,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check),
              //User Icon with UserId copy function
              Tooltip(
                  waitDuration: Duration(milliseconds: 500),
                  message: userId,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: userId));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Copied userID $userId to clipboard')));
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
                    initialValue: 'Dimenzio',
                  ),
                ),
              ),
              //Save new Username Button
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.save),
              ),
              //Delete Button
              IconButton(
                  onPressed: () async {
                    var confirmed = await _showDeleteDialog(context);
                    if (confirmed) {
                      print('Delete Account');
                      //Delete Account
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
