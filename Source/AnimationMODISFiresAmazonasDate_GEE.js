var SRTM = ee.Image("USGS/SRTMGL1_003"),
    region = 
    /* color: #d63000 */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
        [[[-82.22979359894808, 12.872707342195604],
          [-82.22979359894808, -21.149209197634182],
          [-33.186824848948085, -21.149209197634182],
          [-33.186824848948085, 12.872707342195604]]], null, false);

var palettes = require('users/gena/packages:colorbrewer').Palettes;
var utils = require('users/gena/packages:utils');
var text = require('users/gena/packages:text');

print(text)

// Define a collection
var col = ee.ImageCollection('MODIS/006/MCD64A1')
            .filterDate('2019-05-01', '2022-01-01')
             .select('BurnDate');

//Define a mask to clip the data by.
var mask = ee.FeatureCollection('USDOS/LSIB_SIMPLE/2017')
  .filter(ee.Filter.eq('wld_rgn', 'South America'));

print(mask);

// Add outline to the Map as a layer.
Map.centerObject(mask, 3);
//Map.addLayer(mask);  

// Define the regional bounds of animation frames.



print('Region', region) 

// Define RGB visualization parameters.
var visParams = {
  min: 0.0,
  max: 366,
  palette: ['FF0000']
};

// Define GIF visualization parameters.
var gifParams = {
  'region': region,
  'dimensions': 600,
  'crs': 'EPSG:3857',
  'framesPerSecond': 1
};

// define the background map variables
var srtmParams = {
  min: 150,
  max: 255,
  gamma: 1,
};

// Set the for south-america clipped SRTM image as background
var srtm = SRTM.clipToCollection(mask);
var hillshade = ee.Terrain.hillshade(srtm);
var srtmVis = hillshade.visualize(srtmParams);
// Map.addLayer(hillshade, {min: 150, max:255}, 'Hillshade');
// Map.addLayer(srtmVis)

// Create RGB visualization images for use as animation frames.
var rgbVis = col.map(function(img) {
  var start = ee.Date(img.get('system:time_start'));
  var label = start.format('YYYY-MM-dd');
  return srtmVis
        .paint(mask, srtmParams.max, .5)
        .blend(img.visualize(visParams).clipToCollection(mask))
        .set({label: label});

});


print('rgbVis', rgbVis);

// annotate
var annotations = [
  {
    position: 'bottom', offset: '70%', margin: '5%', property: 'label'
  }
];

rgbVis = rgbVis.map(function(image) {
  return text.annotateImage(image, {}, region, annotations)
});
  
  
//Map.addLayer(rgbVis.first())
print('rgbVis', rgbVis);

// add a few layers to map
//var animation = require('users/gena/packages:animation')
//animation.animate(rgbVis, {maxFrames: 5})


// Print the GIF URL to the console.
print(rgbVis.getVideoThumbURL(gifParams));