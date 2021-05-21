joo_global_object.IndirectPromise = function (promise) {
  this.underlying = promise;
};

joo_global_object.IndirectPromise.wrap = function (value) {
  if (
    value !== undefined &&
    value !== null &&
    typeof value.then === "function"
  ) {
    return new IndirectPromise(value);
  } else {
    return value;
  }
};

joo_global_object.IndirectPromise.unwrap = function (value) {
  if (value instanceof joo_global_object.IndirectPromise) {
    return value.underlying;
  } else {
    return value;
  }
};
