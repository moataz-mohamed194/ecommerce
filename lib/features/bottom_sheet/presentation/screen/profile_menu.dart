import 'package:flutter/material.dart';

import '../../../product/presentation/screen/add_product.dart';
import '../../../profile/presentation/screens/get_profile.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/person.jpeg'),
                fit: BoxFit.contain
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.add),
            title: const Text('Profile'),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetProfile()),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.add),
            title: const Text('Add New Product'),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            },
          ),
        ),
      ],
    );
  }
}
