import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy/models/user/user_model.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'abbas ali',
      phone: '+959359345959',
    ),
    UserModel(
      id: 2,
      name: 'Ahmed ail',
      phone: '+473746376476',
    ),
    UserModel(
      id: 3,
      name: 'alla ail',
      phone: '+7878788567',
    ),
    UserModel(
      id: 4,
      name: 'seam indoor',
      phone: '+7878788567',
    ),
    UserModel(
      id: 5,
      name: 'willed abode',
      phone: '+454545455454',
    ),
    UserModel(
      id: 1,
      name: 'abbas ali',
      phone: '+959359345959',
    ),
    UserModel(
      id: 2,
      name: 'Ahmed ail',
      phone: '+473746376476',
    ),
    UserModel(
      id: 3,
      name: 'alla ail',
      phone: '+7878788567',
    ),
    UserModel(
      id: 4,
      name: 'seam indoor',
      phone: '+7878788567',
    ),
    UserModel(
      id: 5,
      name: 'willed abode',
      phone: '+454545455454',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            SizedBox(width: 15.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      );
}
