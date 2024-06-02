import 'package:flutter/material.dart';

import '../pages/contact_details.dart';
import 'contact_tile_action.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.name,
    required this.phone,
    required this.editUser,
    required this.deleteUser,
  });

  final String name;
  final String phone;
  // used VoidCallback as types for the methods being passed into the parameters
  final VoidCallback editUser;
  final VoidCallback deleteUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(name),
            trailing: const Icon(Icons.arrow_right),
            tileColor: Colors.yellow.shade300,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ContactDetails(
                          name: name,
                          phone: phone,
                        )),
                  ));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ContactTileAction(
                buttonType: 'Edit',
                action: editUser,
              ),
              ContactTileAction(
                buttonType: 'Delete',
                action: deleteUser,
              )
            ],
          ),
        ],
      ),
    );
  }
}
