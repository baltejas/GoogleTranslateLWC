public with sharing class TranslateService {
    public TranslateService() {}

    @AuraEnabled(cacheable=true)
    public static string translate(string sourceValue, string targetValue, string sourceText) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        req.setEndpoint('https://google-translate1.p.rapidapi.com/language/translate/v2');
        req.setMethod('POST');
        req.setHeader('X-RapidAPI-Key', 'xxx');
        req.setHeader('X-RapidAPI-Host', 'google-translate1.p.rapidapi.com');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String body = 'q='+sourceText+'&source='+sourceValue+'&target='+targetValue;
        req.setBody(body);
        res = http.send(req);
        Map<string, object> responseMap = (Map<string, object>) JSON.deserializeUntyped(res.getbody());
        Map<string, object>  data = (Map<string, object>) responseMap.get('data');
        Map<string, object> translations = (Map<string, object>)((List<object>) data.get('translations'))[0];
        return (string) translations.get('translatedText');
    }
}
