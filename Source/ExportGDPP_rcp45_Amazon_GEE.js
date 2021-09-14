// 
//
// Define start and end ee.Dates.
var startDate = ee.Date('2010-01-01');
var endDate = ee.Date('2019-01-01');

var dataset = ee.ImageCollection('NASA/NEX-GDDP')
                  .filterDate(startDate, endDate)
                  .filterMetadata('scenario','equals','rcp45');
var minimumAirTemperature = dataset.select('tasmax');
var minimumAirTemperatureVis = {
  min: 240.0,
  max: 300.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
print( 'NEX-GDDP', dataset)

Map.addLayer(
    minimumAirTemperature, minimumAirTemperatureVis, 'Minimum Air Temperature');
    
// Load Amazonian Basin
var amabasin = ee.FeatureCollection("users/arysar/amapoly_ivb");


// Filter fire with more than 50% confidence and add a new band representing areas where confidence of fire > 50%
var clipToRegion = function(img) {
  var clipped = img.clip(amabasin)
  return clipped
};

var ppt_area = dataset.map(clipToRegion);
print('Clipped ', ppt_area)


var scale = ppt_area.first().projection().nominalScale();
print('Scale', scale )

// Count for individual image.
var countIndividualImg = function(image) {
  var date = image.date().format('yyyy-MM-dd')
  var sumObject = image.reduceRegion({
    reducer: ee.Reducer.mean(),
    scale: scale,
    geometry: amabasin,
    maxPixels: 1e9,
    tileScale: 2
  });

  return  ee.Feature(null,{'date':date, 'tasmax':sumObject.get('tasmax'), 
  'pr':sumObject.get('pr')} );
};

var ppt_sum_area = ppt_area.map(countIndividualImg);
print('ppt_sum_area', ppt_sum_area);


Export.table.toDrive({
  collection: ppt_sum_area,
  description: 'GDPP_rcp45_Amazon',
  selectors:['date','tasmax','pr'],
  fileFormat: 'CSV'
});