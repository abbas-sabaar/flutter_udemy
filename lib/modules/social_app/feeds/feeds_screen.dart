import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/social_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/social_app/cubit/states.dart';
import 'package:flutter_udemy/models/social_app/post_model.dart';
import 'package:flutter_udemy/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return ConditionalBuilder(
            condition:SocialCubit.get(context).posts.length > 0 &&SocialCubit.get(context).userModel != null ,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://as2.ftcdn.net/v2/jpg/05/23/54/55/1000_F_523545542_U9O2ZxzgwpE8AX6CJttwS6i2ITj59UJD.jpg'),
                          fit: BoxFit.cover,
                          height: 240.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=> SizedBox(
                      height: 10.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                    '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 18.0,
                            ),
                          ],
                        ),
                        Text(
                            '${model.dateTime}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10.0),
              //           child: Container(
              //             height: 30.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software',
              //                 style: TextStyle(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 10.0),
              //           child: Container(
              //             height: 30.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software_development',
              //                 style:
              //                     Theme.of(context).textTheme.caption!.copyWith(
              //                           color: defaultColor,
              //                         ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15.0,
                ),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}' ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border_outlined,
                                size: 20.0,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                        ),

                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 20.0,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5.0),
                              Text('0 comment',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'writ a comment ...',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Like ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
// https://as2.ftcdn.net/v2/jpg/05/23/54/55/1000_F_523545542_U9O2ZxzgwpE8AX6CJttwS6i2ITj59UJD.jpg