function reduce( initial, array, operation ){
  var accum = initial;
  for ( var i=0; i < array.length; i++ ){
    accum = operation( accum, array[i] );
  };
  return accum;
};

function map( array, operation ){
  return reduce( [], array, function(accum, next){
    accum.push(operation( next ));
    return accum;
 });
};

function filter( array, condition ){
  return reduce( [], array, function(accum, next){
    if (condition(next) == true ){
      accum.push(next);
      return accum;
    }else{
      return accum;
    }
  });
};

function isEven(x){ return x % 2 == 0 };

function zip( arr1, arr2 ){
  newArray = [];
  for (var i = 0; i < arr1.length; i++){
    newArray.push( arr1[i], arr2[i] );
  }
  return newArray;
};

function all( array, condition ){
  for ( var i = 0; i < array.length; i++ ){
    return condition(array[i]);
  }
};
