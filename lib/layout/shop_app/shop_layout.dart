import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_udemy/layout/shop_app/cubit/states.dart';
import 'package:flutter_udemy/modules/shop_app/search/shop_search_screen.dart';
import 'package:flutter_udemy/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, ShopSearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
