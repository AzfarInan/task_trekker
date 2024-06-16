abstract class UseCase<Type, Params> {
  call(Params params);
}

abstract class Params {}

class NoParams extends Params {}
