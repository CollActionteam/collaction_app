import 'package:flutter/material.dart';
import '../themes/constants.dart';
import '../core/collaction_icons.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 22.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: kPrimaryColor600,
                            size: 21.08,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 85,
                      decoration: avatarInfoDecorationBox,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                          right: 25.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AvatarAndInfo(
                              pictureUrl: "pictureUrl",
                              name: "Abdelrhman",
                              phoneNumber: "+970597501896",
                            ),
                            GestureDetector(
                              onTap: () {
                                debugPrint('Button tapped');
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.settings,
                                    color: kPrimaryColor600,
                                    size: 21,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 18,),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: kErrorColor,
                          ),
                          SizedBox(
                            width: 2.5,
                          ),
                          Text(
                            "Log out",
                            style: TextStyle(
                              color: kErrorColor,
                              fontFamily: "Rubik",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildSubTitle(
                  subTitle: "Account", paddingTop: 38.5, paddingBottom: 20),
              Padding(
                padding: const EdgeInsets.only(left: 22.25),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: kPrimaryColor300,
                        size: 19.5,
                      ),
                      SizedBox(
                        width: 12.25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account Information",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kPrimaryColor300),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 306,
                            child: Text(
                              "View and update your account  and contact information that is associated with your CollAction account.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kPrimaryColor300,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              _buildSubTitle(
                  subTitle: "Feedback", paddingTop: 30, paddingBottom: 20),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22.5,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CollactionIcons.message,
                        color: kPrimaryColor300,
                        size: 15,
                      ),
                      SizedBox(
                        width: 16.25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact us",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kPrimaryColor300),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 305,
                            child: Text(
                              "Have a general enquiry, business proposal, or simply want us to send your feedback or regards? Get in contact with us through our form.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kPrimaryColor300,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildSubTitle(
                  subTitle: "Legal information and policies",
                  paddingBottom: 24,
                  paddingTop: 30),
              LegalInfoAndPoliciesWidget(
                  onTap: () {},
                  iconWidget: CollactionIcons.lock,
                  label: "Privacy Policy"),
              LegalInfoAndPoliciesWidget(
                  onTap: () {},
                  iconWidget: CollactionIcons.file,
                  label: "Terms & conditions"),
              LegalInfoAndPoliciesWidget(
                  onTap: () {},
                  iconWidget: CollactionIcons.opensource,
                  label: "Privacy Policy"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/collaction.png"),
                        width: 120,
                        height: 20.36,
                      ),
                      SizedBox(height: 4,),
                      Text('Build 443'  ,style: appInfo,),
                      Text('Version 1.0.1',style: appInfo),
                      Text('Stichting CollAction',style: appInfo)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle(
      {required String subTitle,
      double paddingTop = 0.0,
      double paddingBottom = 0.0}) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20, top: paddingTop, bottom: paddingBottom),
      child: Text(
        subTitle,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kPrimaryColor300,
        ),
      ),
    );
  }
}

class AvatarAndInfo extends StatelessWidget {
  final String pictureUrl;
  final String name;
  final String phoneNumber;

  const AvatarAndInfo(
      {Key? key,
      required this.pictureUrl,
      required this.name,
      required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: nameTextStyle,
            ),
            Text(
              phoneNumber,
              style: phoneNumberTextStyle,
            ),
          ],
        )
      ],
    );
  }
}

class LegalInfoAndPoliciesWidget extends StatefulWidget {
  final Function onTap;
  final IconData iconWidget;
  final String label;

  const LegalInfoAndPoliciesWidget(
      {Key? key,
      required this.onTap,
      required this.iconWidget,
      required this.label})
      : super(key: key);

  @override
  State<LegalInfoAndPoliciesWidget> createState() =>
      _LegalInfoAndPoliciesWidgetState();
}

class _LegalInfoAndPoliciesWidgetState
    extends State<LegalInfoAndPoliciesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 27.6),
      child: InkWell(
        onTap: widget.onTap(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.iconWidget,
              size: 20,
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
