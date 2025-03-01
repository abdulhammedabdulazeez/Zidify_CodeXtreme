import 'package:zidify_app/features/saveBox/ui/widgets/savebox_loaded.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/saveBox/cubit/save_box_cubit.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveboxMainScreen extends StatefulWidget {
  const SaveboxMainScreen({super.key});

  @override
  State<SaveboxMainScreen> createState() => _SaveboxMainScreenState();
}

class _SaveboxMainScreenState extends State<SaveboxMainScreen> {
  late SaveBoxCubit bloc = sl<SaveBoxCubit>();

  String navigateWithdrawRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.withdrawFirstScreenRoute}';
  }

  String navigateDepositRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}';
  }

  @override
  void initState() {
    super.initState();
    // context.read<SaveBoxCubit>().getSaveBox();
    bloc.getSaveBox();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            bloc.getSaveBox();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.md, horizontal: AppSizes.md),
            child: BlocConsumer<SaveBoxCubit, SaveBoxState>(
              // bloc: context.read<SaveBoxCubit>(),
              bloc: bloc,
              listener: (context, state) {
                if (state is SaveBoxErrorState) {
                  // Show error SnackBar on error
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is SaveBoxLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SaveBoxErrorState) {
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else if (state is SaveBoxLoadedState) {
                  final saveBox = state.saveBox;
                  return SaveBoxLoadedWidget(saveBox: saveBox);
                } else {
                  return const SizedBox(
                    child: Text('There is nothing here'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
