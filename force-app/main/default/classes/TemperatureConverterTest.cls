@isTest
public class TemperatureConverterTest {
    
    @isTest
    public static void testWarmTemp(){
        Decimal celsius1 = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius1);
    }
    
    @isTest
    public static void testFreezingTemp(){
        Decimal celsius2 = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0, celsius2);
    }
    
    @isTest
    public static void testBoilingPoint(){
        Decimal celsius3 = TemperatureConverter.FahrenheitToCelsius(212);
        //simulate failure ......
        System.assertEquals(0, celsius3,'Boiling Point Temperature is not Expected !');
    }
    
    @isTest
    public static void testNegetiveTemp(){
        Decimal celsius4 = Temperatureconverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius4);
    }
	
}