// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer_utilities/check/check.dart';
import 'package:test/test.dart';

void main() {
  group('type', () {
    group('bool', () {
      test('isEqualTo', () {
        check(true).isEqualTo(true);
        check(false).isEqualTo(false);
        _fails(() => check(true).isEqualTo(false));
        _fails(() => check(false).isEqualTo(true));
      });
      test('isFalse', () {
        check(false).isFalse;
        _fails(() => check(true).isFalse);
      });
      test('isNotEqualTo', () {
        check(true).isNotEqualTo(false);
        check(false).isNotEqualTo(true);
        _fails(() => check(true).isNotEqualTo(true));
        _fails(() => check(false).isNotEqualTo(false));
      });
      test('isTrue', () {
        check(true).isTrue;
        _fails(() => check(false).isTrue);
      });
    });
    group('int', () {
      test('isEqualTo', () {
        check(0).isEqualTo(0);
        check(1).isEqualTo(1);
        check(2).isEqualTo(2);
        _fails(() => check(0).isEqualTo(1));
        _fails(() => check(1).isEqualTo(0));
      });
      test('isGreaterThan', () {
        check(2).isGreaterThan(1);
        check(1).isGreaterThan(0);
        check(-1).isGreaterThan(-2);
        _fails(() => check(0).isGreaterThan(0));
        _fails(() => check(0).isGreaterThan(1));
        _fails(() => check(1).isGreaterThan(2));
        _fails(() => check(-2).isGreaterThan(-1));
      });
      test('isNotEqualTo', () {
        check(0).isNotEqualTo(1);
        check(1).isNotEqualTo(0);
        check(1).isNotEqualTo(2);
        check(2).isNotEqualTo(1);
        _fails(() => check(0).isNotEqualTo(0));
        _fails(() => check(1).isNotEqualTo(1));
        _fails(() => check(2).isNotEqualTo(2));
      });
      test('isZero', () {
        check(0).isZero;
        _fails(() => check(1).isZero);
        _fails(() => check(-1).isZero);
      });
    });
    group('Iterable', () {
      test('hasLength', () {
        check(<int>[]).hasLength().isZero;
        check(<int>[0]).hasLength().isEqualTo(1);
        check(<int>[0]).hasLength(1);
        check(<int>[0, 1]).hasLength().isEqualTo(2);
        check(<int>[0, 1]).hasLength(2);
        check(<int>{}).hasLength().isZero;
        check(<int>{0}).hasLength().isEqualTo(1);
        check(<int>{0}).hasLength(1);
        check(<int>{0, 1}).hasLength().isEqualTo(2);
        check(<int>{0, 1}).hasLength(2);
        _fails(() => check(<int>[]).hasLength(1));
        _fails(() => check(<int>[]).hasLength(2));
        _fails(() => check(<int>{}).hasLength(1));
        _fails(() => check(<int>{}).hasLength(2));
        _fails(() => check(<int>[]).hasLength().isEqualTo(1));
        _fails(() => check(<int>[0]).hasLength().isEqualTo(0));
      });
      test('isEmpty', () {
        check(<int>[]).isEmpty;
        check(<int>{}).isEmpty;
        _fails(() => check([0]).isEmpty);
        _fails(() => check([0, 1]).isEmpty);
        _fails(() => check({0}).isEmpty);
        _fails(() => check({0, 1}).isEmpty);
      });
      test('isNotEmpty', () {
        check([0]).isNotEmpty;
        check([0, 1]).isNotEmpty;
        check({0}).isNotEmpty;
        check({0, 1}).isNotEmpty;
        _fails(() => check(<int>[]).isNotEmpty);
        _fails(() => check(<int>{}).isNotEmpty);
      });
    });
    group('String', () {
      test('contains', () {
        check('abc').contains('a');
        check('abc').contains('b');
        check('abc').contains('c');
        check('abc').contains('ab');
        check('abc').contains('bc');
        check('abc').contains(RegExp('a'));
        check('abc').contains(RegExp('a.'));
        check('abc').contains(RegExp('a.c'));
        check('abc').contains(RegExp('.b.'));
        _fails(() => check('abc').contains('x'));
        _fails(() => check('abc').contains('ac'));
        _fails(() => check('abc').contains(RegExp('ac.')));
      });
      test('hasLength', () {
        check('').hasLength().isZero;
        check('').hasLength(0);
        check('a').hasLength().isEqualTo(1);
        check('a').hasLength(1);
        check('abc').hasLength().isEqualTo(3);
        check('abc').hasLength(3);
        _fails(() => check('abc').hasLength(0));
        _fails(() => check('abc').hasLength(1));
        _fails(() => check('abc').hasLength(2));
      });
      test('isEqualTo', () {
        check('').isEqualTo('');
        check('abc').isEqualTo('abc');
        check('foobar').isEqualTo('foobar');
        _fails(() => check('abc').isEqualTo('ab'));
        _fails(() => check('abc').isEqualTo('xyz'));
      });
      test('isNotEqualTo', () {
        check('abc').isNotEqualTo('ab');
        check('abc').isNotEqualTo('xyz');
        _fails(() => check('abc').isNotEqualTo('abc'));
        _fails(() => check('foobar').isNotEqualTo('foobar'));
      });
      test('startsWith', () {
        check('abc').startsWith('a');
        check('abc').startsWith('ab');
        check('abc').startsWith('abc');
        check('abc').startsWith(RegExp('..c'));
        check('abc').startsWith(RegExp('.*c'));
        _fails(() => check('abc').startsWith('b'));
        _fails(() => check('abc').startsWith('x'));
        _fails(() => check('abc').startsWith(RegExp('.c')));
      });
    });
    group('type', () {
      test('isA', () {
        check(0).isA<int>();
        _fails(() => check('abc' as dynamic).isA<int>());
      });
    });
  });
}

void _fails(void Function() f) {
  try {
    f();
  } on TestFailure {
    return;
  }
  fail('expected to fail');
}
