var customParam = encodeURI('utm_source=support&medium=email&message=...');
chrome.browserAction.onClicked.addListener(function (tab) {
    var url = tab.url;
    var hashStart   = (url.indexOf('#') === -1) ? url.length : url.indexOf('#');
    var querySymbol = (url.indexOf('?') === -1) ? '?' : '&';
    var newURL      = url.substring(0, hashStart) + querySymbol
                      + customParam + url.substring(hashStart);
    chrome.tabs.update(tab.id, {url: newURL});
});
