public with sharing class WeatherAppController {
    @AuraEnabled
    public static String getWeatherDetails(String cityName){
        String url='https://api.openweathermap.org/data/2.5/weather?q='+cityName+'&units=metric'+getKey();
        String response=getResponse(url);
        return response;
    }

    public static String getResponse(String url){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        HttpResponse res=new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(url);
        req.setTimeout(120000);
        res=http.send(req);
        String responseBody=res.getBody();
        return responseBody;
        
    }

    public static String getKey(){
        String key='459114c65df906ad660aa31ba910d995';
        String output='&appid='+key;
        return output;
    }
}