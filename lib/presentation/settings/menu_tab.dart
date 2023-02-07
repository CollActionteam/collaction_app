import 'package:flutter/material.dart';
import '../../presentation/themes/constants.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({Key? key}) : super(key: key);

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
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
              SizedBox(height: 38.5),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: kPrimaryColor300,
                    ),
                    SizedBox(
                      width: 18.25,
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
                          width: 275,
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
              SizedBox(
                height: 30,
              ),
              Text(
                "Feedback",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sms,
                      color: kPrimaryColor300,
                    ),
                    SizedBox(
                      width: 18.25,
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
                          width: 275,
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
              SizedBox(height: 30,),
              Text(
                "Legal information and policies",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor300,
                ),
              ),
            ],
          ),
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
