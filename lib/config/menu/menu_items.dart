import 'package:flutter/material.dart';


class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon
  });
}


const appMenuItems = <MenuItem>[


  MenuItem(
    title: 'easy', 
    subTitle: 'easy mode', 
    link: '/easy', 
    icon: Icons.circle
  ),

  MenuItem(
    title: 'normal', 
    subTitle: 'normal mode', 
    link: '/normal', 
    icon: Icons.circle
  ),

  MenuItem(
    title: 'hard', 
    subTitle: 'hard mode', 
    link: '/hard', 
    icon: Icons.circle
  ),


  // MenuItem(
  //   title: 'change theme', 
  //   subTitle: 'Cambiar tema de la aplicación', 
  //   link: '/theme-changer', 
  //   icon: Icons.color_lens_outlined
  // ),



];


