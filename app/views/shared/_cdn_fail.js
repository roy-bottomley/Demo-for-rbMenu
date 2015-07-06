if (typeof jQuery == 'undefined') {
    console.log("local jquery")
    document.write('<script src="/cdn_fail/jquery-2.1.3.min.js"><\/script>');
    document.write('<script src="/cdn_fail/jquery-ui.min.js"><\/script>');
}
if (typeof angular == 'undefined') {
    console.log("local angular")
    document.write('<script src="/cdn_fail/angular1.2.13.min.js"><\/script>');
    document.write('<script src="/cdn_fail/angular-resource1.2.13.min.js"><\/script>');
}