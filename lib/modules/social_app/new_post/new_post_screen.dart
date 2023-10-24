import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/cubit/states.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  print(now.toString());
                  print(now.toLocal());
                  if(SocialCubit.get(context).postImage  == null )
                  {
                   SocialCubit.get(context).createPost(
                       dateTime: now.toString(),
                       text: textController.text,
                   );
                  } else
                  {
                    SocialCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                    );
                  }
                },
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(states is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://as2.ftcdn.net/v2/jpg/05/23/54/55/1000_F_523545542_U9O2ZxzgwpE8AX6CJttwS6i2ITj59UJD.jpg'),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Text(
                        'Abbas Sabaar',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind, ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                  SizedBox(height: 20.0),
                if(SocialCubit.get(context).postImage != null )
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 5.0),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tage'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
