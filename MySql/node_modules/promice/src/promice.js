'use strict';

const {
  validStates,
  isValidState,
  isFunction,
  isObject,
  runAsync
} = require('./utils');
const isPromise = value => value && value.constructor === Promice;

const then = function(onFulfilled, onRejected) {
  const queuedPromise = new Promice();
  if (isFunction(onFulfilled)) {
    queuedPromise.handlers.fulfill = onFulfilled;
  }

  if (isFunction(onRejected)) {
    queuedPromise.handlers.reject = onRejected;
  }

  this.queue.push(queuedPromise);
  this.handle();

  return queuedPromise;
};

const transition = function(state, value) {
  if (
    this.state === state ||
    this.state !== validStates.PENDING ||
    !isValidState(state) ||
    arguments.length !== 2
  ) {
    return;
  }

  this.value = value;
  this.state = state;
  this.handle();
};

const handle = function() {
  function fulfillFallBack(value) {
    return value;
  }
  function rejectFallBack(reason) {
    throw reason;
  }

  if (this.state === validStates.PENDING) {
    return;
  }

  runAsync(() => {
    while (this.queue.length) {
      const queuedPromise = this.queue.shift();
      let handler = null, value;

      if (this.state === validStates.FULFILLED) {
        handler = queuedPromise.handlers.fulfill || fulfillFallBack;
      } else if (this.state === validStates.REJECTED) {
        handler = queuedPromise.handlers.reject || rejectFallBack;
      }

      try {
        value = handler(this.value);
      } catch (e) {
        queuedPromise.transition(validStates.REJECTED, e);
        continue;
      }

      Resolve(queuedPromise, value);
    }
  });
};

function Resolve(promise, x) {
  if (promise === x) {
    promise.transition(
      validStates.REJECTED,
      new TypeError('The promise and its value refer to the same object')
    );
  } else if (isPromise(x)) {
    if (x.state === validStates.PENDING) {
      x.then(
        function(val) {
          Resolve(promise, val);
        },
        function(reason) {
          promise.transition(validStates.REJECTED, reason);
        }
      );
    } else {
      promise.transition(x.state, x.value);
    }
  } else if (isObject(x) || isFunction(x)) {
    let called = false, thenHandler;
    try {
      thenHandler = x.then;

      if (isFunction(thenHandler)) {
        thenHandler.call(
          x,
          function(y) {
            if (!called) {
              Resolve(promise, y);
              called = true;
            }
          },
          function(r) {
            if (!called) {
              promise.reject(r);
              called = true;
            }
          }
        );
      } else {
        promise.fulfill(x);
        called = true;
      }
    } catch (e) {
      if (!called) {
        promise.reject(e);
        called = true;
      }
    }
  } else {
    promise.fulfill(x);
  }
}

const fulfill = function(value) {
  this.transition(validStates.FULFILLED, value);
};

const reject = function(reason) {
  this.transition(validStates.REJECTED, reason);
};

const Promice = function(fn) {
  this.value = null;
  this.state = validStates.PENDING;
  this.queue = [];
  this.handlers = {
    fulfill: null,
    reject: null
  };

  if (fn) {
    fn(val => Resolve(this, val), reason => this.reject(reason));
  }
};

Promice.prototype.transition = transition;
Promice.prototype.handle = handle;
Promice.prototype.then = then;
Promice.prototype.fulfill = fulfill;
Promice.prototype.reject = reject;

module.exports = Promice;
