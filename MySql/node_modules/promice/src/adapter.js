'use strict';

const Promice = require('./promice');

module.exports = {
  resolved: function(value) {
    return new Promice(function(resolve) {
      resolve(value);
    });
  },
  rejected: function(reason) {
    return new Promice(function(resolve, reject) {
      reject(reason);
    });
  },
  deferred: function() {
    var resolve, reject;

    return {
      promise: new Promice(function(rslv, rjct) {
        resolve = rslv;
        reject = rjct;
      }),
      resolve: resolve,
      reject: reject
    };
  }
};
