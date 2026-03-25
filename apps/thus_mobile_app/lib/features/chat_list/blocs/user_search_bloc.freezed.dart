// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSearchEvent()';
}


}




/// Adds pattern-matching-related methods to [UserSearchEvent].
extension UserSearchEventPatterns on UserSearchEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QueryChanged value)?  queryChanged,TResult Function( _Retried value)?  retried,TResult Function( _Search value)?  search,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Retried() when retried != null:
return retried(_that);case _Search() when search != null:
return search(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QueryChanged value)  queryChanged,required TResult Function( _Retried value)  retried,required TResult Function( _Search value)  search,}){
final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that);case _Retried():
return retried(_that);case _Search():
return search(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QueryChanged value)?  queryChanged,TResult? Function( _Retried value)?  retried,TResult? Function( _Search value)?  search,}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Retried() when retried != null:
return retried(_that);case _Search() when search != null:
return search(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  queryChanged,TResult Function()?  retried,TResult Function( String query)?  search,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Retried() when retried != null:
return retried();case _Search() when search != null:
return search(_that.query);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  queryChanged,required TResult Function()  retried,required TResult Function( String query)  search,}) {final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that.query);case _Retried():
return retried();case _Search():
return search(_that.query);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  queryChanged,TResult? Function()?  retried,TResult? Function( String query)?  search,}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Retried() when retried != null:
return retried();case _Search() when search != null:
return search(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _QueryChanged implements UserSearchEvent {
  const _QueryChanged(this.query);
  

 final  String query;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'UserSearchEvent.queryChanged(query: $query)';
}


}




/// @nodoc


class _Retried implements UserSearchEvent {
  const _Retried();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Retried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserSearchEvent.retried()';
}


}




/// @nodoc


class _Search implements UserSearchEvent {
  const _Search(this.query);
  

 final  String query;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Search&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'UserSearchEvent.search(query: $query)';
}


}




/// @nodoc
mixin _$UserSearchState {

 String get query; UserSearchStatus get status; List<Profile> get results; String? get errorMessage;
/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchStateCopyWith<UserSearchState> get copyWith => _$UserSearchStateCopyWithImpl<UserSearchState>(this as UserSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,query,status,const DeepCollectionEquality().hash(results),errorMessage);

@override
String toString() {
  return 'UserSearchState(query: $query, status: $status, results: $results, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UserSearchStateCopyWith<$Res>  {
  factory $UserSearchStateCopyWith(UserSearchState value, $Res Function(UserSearchState) _then) = _$UserSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, UserSearchStatus status, List<Profile> results, String? errorMessage
});




}
/// @nodoc
class _$UserSearchStateCopyWithImpl<$Res>
    implements $UserSearchStateCopyWith<$Res> {
  _$UserSearchStateCopyWithImpl(this._self, this._then);

  final UserSearchState _self;
  final $Res Function(UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? status = null,Object? results = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserSearchStatus,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Profile>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchState].
extension UserSearchStatePatterns on UserSearchState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchState value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  UserSearchStatus status,  List<Profile> results,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.query,_that.status,_that.results,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  UserSearchStatus status,  List<Profile> results,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _UserSearchState():
return $default(_that.query,_that.status,_that.results,_that.errorMessage);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  UserSearchStatus status,  List<Profile> results,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.query,_that.status,_that.results,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchState implements UserSearchState {
  const _UserSearchState({this.query = '', this.status = UserSearchStatus.idle, final  List<Profile> results = const [], this.errorMessage}): _results = results;
  

@override@JsonKey() final  String query;
@override@JsonKey() final  UserSearchStatus status;
 final  List<Profile> _results;
@override@JsonKey() List<Profile> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  String? errorMessage;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchStateCopyWith<_UserSearchState> get copyWith => __$UserSearchStateCopyWithImpl<_UserSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,query,status,const DeepCollectionEquality().hash(_results),errorMessage);

@override
String toString() {
  return 'UserSearchState(query: $query, status: $status, results: $results, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UserSearchStateCopyWith<$Res> implements $UserSearchStateCopyWith<$Res> {
  factory _$UserSearchStateCopyWith(_UserSearchState value, $Res Function(_UserSearchState) _then) = __$UserSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, UserSearchStatus status, List<Profile> results, String? errorMessage
});




}
/// @nodoc
class __$UserSearchStateCopyWithImpl<$Res>
    implements _$UserSearchStateCopyWith<$Res> {
  __$UserSearchStateCopyWithImpl(this._self, this._then);

  final _UserSearchState _self;
  final $Res Function(_UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? status = null,Object? results = null,Object? errorMessage = freezed,}) {
  return _then(_UserSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserSearchStatus,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Profile>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
