import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';

final class ProfileView extends HookWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthBloc>().state.session;
    final bloc = useMemoized(
      () => ProfileBloc(context.read<ContactRepository>()),
    );
    useEffect(() {
      if (session != null) {
        bloc.add(ProfileStarted(userId: session.userId));
      }
      return bloc.close;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: const _ProfileContent(),
    );
  }
}

final class _ProfileContent extends HookWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthBloc>().state.session;
    final displayNameCtrl = useTextEditingController();
    final bioCtrl = useTextEditingController();
    final avatarCtrl = useTextEditingController();

    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.isSuccess && state.profile != null) {
          displayNameCtrl.text = state.profile!.displayName ?? '';
          bioCtrl.text = state.profile!.bio ?? '';
          avatarCtrl.text = state.profile!.avatarUrl ?? '';
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Error loading profile.')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
            actions: [
              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (state.profile != null) ...[
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      (state.profile!.displayName ??
                              state.profile!.username)[0]
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '@${state.profile!.username}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              TextField(
                controller: displayNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Display name',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: avatarCtrl,
                decoration: const InputDecoration(
                  labelText: 'Avatar URL',
                  prefixIcon: Icon(Icons.image_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  prefixIcon: Icon(Icons.info_outline),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        if (session == null) return;
                        context.read<ProfileBloc>().add(
                              ProfileUpdated(
                                userId: session.userId,
                                displayName:
                                    displayNameCtrl.text.trim().isEmpty
                                        ? null
                                        : displayNameCtrl.text.trim(),
                                avatarUrl: avatarCtrl.text.trim().isEmpty
                                    ? null
                                    : avatarCtrl.text.trim(),
                                bio: bioCtrl.text.trim().isEmpty
                                    ? null
                                    : bioCtrl.text.trim(),
                              ),
                            );
                      },
                child: const Text('Save profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}
