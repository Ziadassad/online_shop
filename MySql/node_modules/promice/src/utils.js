'use strict';

const validStates = {
  PENDING: 0,
  FULFILLED: 1,
  REJECTED: 2
};

const isValidState = state => state === validStates.PENDING ||
                              state === validStates.REJECTED ||
                              state === validStates.FULFILLED

const isFunction = value => value && typeof value === 'function';
const isObject = value => value && typeof value === 'object';
const runAsync = fn => setTimeout(fn, 0);

module.exports = {
  validStates,
  isValidState,
  isFunction,
  isObject,
  runAsync
};
