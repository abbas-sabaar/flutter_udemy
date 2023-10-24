import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/cubit/states.dart';
import 'package:flutter_udemy/modules/social_app/new_post/new_post_screen.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {

        if(states is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, states) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton( icon: Icon(Icons.notifications_none_outlined,),onPressed: (){}),
              IconButton( icon: Icon(Icons.search,),onPressed: (){}),
            ],
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(Icons.location_on),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
