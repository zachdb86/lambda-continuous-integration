console.log('Loading function');

exports.handler = function(event, context){
    console.log('value1 =', event.key1);
    console.log('value2 =', event.key2);
    console.log('value3 =', event.key3);
    context.succeed(event.key1 + " this is working");
    context.fail('Somthing went wrong');
    //test
};
