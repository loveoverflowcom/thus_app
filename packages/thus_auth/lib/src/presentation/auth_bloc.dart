import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thus_core/thus_core.dart';

import '../domain/entities/user_identity.dart';
import '../domain/usecases/generate_key_pair.dart';
import '../domain/usecases/load_identity.dart';
import '../domain/usecases/save_identity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._loadIdentity, this._generateKeyPair, this._saveIdentity) : super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<CreateIdentity>(_onCreateIdentity);
  }

  final LoadIdentity _loadIdentity;
  final GenerateKeyPair _generateKeyPair;
  final SaveIdentity _saveIdentity;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final identity = await _loadIdentity.call(const NoParams());
    if (identity != null) {
      emit(AuthState.authenticated(identity));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onCreateIdentity(CreateIdentity event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final identity = await _generateKeyPair.call(event.displayName);
      await _saveIdentity.call(identity);
      emit(AuthState.authenticated(identity));
    } catch (e, st) {
      emit(AuthState.failure(e.toString()));
      addError(e, st);
    }
  }
}
