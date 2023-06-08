import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/color.dart';
import '../APIServer/user_service.dart';

class HomeUserHeaderView extends StatelessWidget {
  const HomeUserHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, viewModel, _) {
        return Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 74),
          child: Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: Image(
                    image: viewModel.memberData == null
                        ? const AssetImage("assets/avatars/01.png")
                        : Image.network(viewModel.memberData?.avatar ?? "")
                            .image,
                    width: 40,
                    height: 40),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning",
                    style: TextStyle(
                        color: ThemeProvider.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    viewModel.memberData?.name ?? "Go Login",
                    style: TextStyle(
                        color: ThemeProvider.textActivate,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
              const Spacer(),
              const Image(
                image: AssetImage("assets/icons/Search.png"),
                width: 35,
                height: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              const Image(
                image: AssetImage("assets/icons/Plus.png"),
                width: 35,
                height: 35,
              ),
            ],
          ),
        );
      },
    );
  }
}
