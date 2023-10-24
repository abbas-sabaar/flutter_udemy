import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/cubit/states.dart';
import 'package:flutter_udemy/models/social_app/social_user_model.dart';
import 'package:flutter_udemy/modules/social_app/shat_details/chat_details_screen.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length > 0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem (SocialUserModel model,context)=>   InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ),
      );
    } ,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 15.0),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}



