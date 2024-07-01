import { LightningElement,api,wire } from 'lwc';
import WEATHER_ICONS from '@salesforce/resourceUrl/Weather_App_Icons';
import getWeatherDetails from '@salesforce/apex/WeatherAppController.getWeatherDetails';
// const API_KEY = '459114c65df906ad660aa31ba910d995';

export default class WeatherApp extends LightningElement {
    clearIcon = WEATHER_ICONS + '/weatherAppIcons/clear.svg'
    cloudIcon = WEATHER_ICONS + '/weatherAppIcons/cloud.svg'
    hazeIcon = WEATHER_ICONS + '/weatherAppIcons/haze.svg'
    rainIcon = WEATHER_ICONS + '/weatherAppIcons/rain.svg'
    dropletIcon = WEATHER_ICONS + '/weatherAppIcons/droplet.svg'
    snowIcon = WEATHER_ICONS + '/weatherAppIcons/snow.svg'
    stormIcon = WEATHER_ICONS + '/weatherAppIcons/storm.svg'
    thermometerIcon = WEATHER_ICONS + '/weatherAppIcons/thermometer.svg'
    mapIcon=WEATHER_ICONS + '/weatherAppIcons/map.svg'
    arrowBackIcon=WEATHER_ICONS + '/weatherAppIcons/arrow-back.svg'



    cityName = '';
    loadingText = '';
    isError = false;
    response;
    weatherIcon='';

    
    get loadingClasses () { 
        return this.isError ?   'error-message':'success-message';
    }
    searchHandler (e) { 
        this.cityName = e.target.value;
    }

    submitHandler (e) { 
        e.preventDefault();
        this.fetchData();
    }

    fetchData () { 
        this.isError = false;
        this.loadingText = 'fetching weather details ...';
        // const URL = `https://api.openweathermap.org/data/2.5/weather?q=${ this.cityName }&units=metric&appid=${ API_KEY }`;
        
        // server side call
        getWeatherDetails({ cityName: this.cityName })
            .then(result => { 
                this.weatherDetails(JSON.parse(result));
            })
            .catch(err => { 
                this.response = null;
                console.log(err);
                this.loadingText = 'Something Went Wrong !';
                this.isError = true;
            })
        // client side call 
        
        // fetch(URL)
        //     .then(res => res.json())
        //     .then(result => { 
        //         JSON.stringify(result);
                
        //         this.weatherDetails(result);
        //     }).catch(err => { 
        //         console.log(err);
        //         this.loadingText = 'Something Went Wrong !';
        //         this.isError = true;
        //     })

    }

    weatherDetails (info) { 
        if (info.cod === '404')
        {
            this.isError = true;
            this.loadingText = `${ this.cityName } was not found !`
        } else
        { 
            this.loadingText = '';
            const city = info.name;
            const country = info.sys.country;
            
            const { humidity,temp,feels_like } = info.main
            const { description, id } = info.weather[0];
            /* weather icon */
            if (id === 800)
            {
                this.weatherIcon = this.clearIcon;
            }
            else if (id >= 200 && id <= 232)
            {
                this.weatherIcon = this.stormIcon;
            }
            else if (id >= 600 && id <= 622)
            {
                this.weatherIcon = this.stormIcon;
            }
            else if (id >= 701 && id <= 781)
            {
                this.weatherIcon = this.hazeIcon;
            }
            else if (id >= 801 && id <= 804)
            {
                this.weatherIcon = this.cloudIcon;
            } else if ((id >= 500 && id <= 531) || (id >= 300 && id <= 321))
            {
                this.weatherIcon = this.rainIcon;
            }
            else
            { 
                
            }
            this.response = {
                location:`${city} , ${country}`,
                temperature: Math.floor(temp),
                humidity: humidity,
                feelsLike: feels_like,
                description: description,
                id: id,
                
            }
        }
    }
}