
// Define start and end ee.Dates.
var startDate = ee.Date('2000-01-01');
var endDate = ee.Date('2021-01-01');

// Calc number of days between start and end dates.
var nDays = ee.Number(endDate.difference(startDate, 'month')).toInt8();
print('Months', nDays)


// Define base collection with hourly data

//var ppt = ee.ImageCollection("NASA/GPM_L3/IMERG_V06")
//                  .filterDate(startDate, endDate )
//                  .select('HQprecipitation');

// Define base collection 
var ppt =  ee.ImageCollection("IDAHO_EPSCOR/TERRACLIMATE")
              .filterDate(startDate, endDate )
              .select('pr','tmmx');

// Load Amazonian Basin
var amabasin = ee.FeatureCollection("users/arysar/amapoly_ivb");



// Function to clip to region
//
var clipToRegion = function(img) {
  var clipped = img.clip(amabasin)
  return clipped
};

var ppt_area = ppt.map(clipToRegion);
print('Clipped ', ppt_area)  
  
// Map.addLayer(protectedAreas, {}, 'Region');


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
  var varObject = image.unmask().reduceRegion({
    reducer: ee.Reducer.variance(),
    scale: scale,
    geometry: amabasin,
    maxPixels: 1e9,
    tileScale: 2
  });

  return  ee.Feature(null,{'date':date, 'pr':sumObject.get('pr'), 
  'tmmx':sumObject.get('tmmx')} );
};

var ppt_sum_area = ppt_area.map(countIndividualImg);
print('ppt_sum_area', ppt_sum_area);


Export.table.toDrive({
  collection: ppt_sum_area,
  description: 'TerraClimatePrAmazonas',
  selectors:['date','pr','tmmx'],
  fileFormat: 'CSV'
});