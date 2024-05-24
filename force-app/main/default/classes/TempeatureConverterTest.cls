@isTest
public  class TempeatureConverterTest {
    
    @isTest static void testWarmTemp(){
        Decimal celcius=TemperatureConverter.FahrenheitToCelcius(70);
        System.assertEquals(21.11, celcius);
    }

    @isTest static void testFreezingTemp(){
        Decimal celcius=TemperatureConverter.FahrenheitToCelcius(32);
        System.assertEquals(0,celcius);
    }

    @isTest static void testBoilingTemp(){
        Decimal celcius=TemperatureConverter.FahrenheitToCelcius(212);
        System.assertEquals(100,celcius);
    }

    @isTest static void testNegetiveTemp(){
        Decimal celcius=TemperatureConverter.FahrenheitToCelcius(-10);
        System.assertEquals(-23.33,celcius);
    }

}