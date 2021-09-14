// Export Burned Area Amazon  
// Export geotif images with 12 layer representing burned pixels by year
//
// Define start and end ee.Dates.
var startDate = ee.Date('2000-01-01');
var endDate = ee.Date('2021-04-01');

var col =  ee.ImageCollection("MODIS/006/MCD64A1")
             .select('BurnDate');


// Load Amazonia Basin
var countries = ee.FeatureCollection("users/arysar/amapoly_ivb");

// Subset the to a Country .
var congo = ee.Feature(
  countries
//    .filter(ee.Filter.eq('country_na', 'Brazil'))
    .first()
);

// Load a FeatureCollection from a table dataset: 'RESOLVE' ecoregions.
var ecoregions = ee.FeatureCollection('RESOLVE/ECOREGIONS/2017');

//Map.addLayer(ecoregions, {bands}, 'default display');

// Subset protected areas to the bounds of the ecoregion feature
// and other criteria. Clip to the intersection with congo.
/* var protectedAreas = ecoregions
  .filter(ee.Filter.and(
    ee.Filter.bounds(congo.geometry()),
    ee.Filter.eq('BIOME_NUM', 1) // 4. Temperate broadleaf and mixed forests
  ))
  .map(function(feat){
    return congo.intersection(feat);
  });

Map.centerObject(protectedAreas, 5);
Map.addLayer(protectedAreas, {}, 'Amazon Biome 1 TMBF');  
Map.addLayer(congo.simplify(1))
*/
congo = congo.simplify(1);

// create years and export for every year
var years = Array.apply(null, {length: 22}).map(Number.call, Number) // sequence of 16 numbers
            .map(function(number){
              return exportImagePerYear(col, number + 2000)}); // add 2000 for each year

var scale = col.first().projection().nominalScale().getInfo();
print('Scale', scale);

// function to export
function exportImagePerYear(col, startYear) {

  var colFilt = col.filterDate(String(startYear)+'-01-01', String(startYear+1)+'-01-01');

  // Filter fire with more than 50% confidence and add a new band representing areas where confidence of fire > 50%
  var clipToRegion = function(img) {
    var dateString = ee.Date(img.get('system:time_start')).format('yyyy-MM-dd');
    var clipped = img.clip(congo)
  //  var burned = clipped.gt(0);
    return clipped.rename(dateString)
  };
  var burned_area = colFilt.map(clipToRegion);

  //var check = ee.Image(burned_area.first());
  //Map.addLayer(check, {palette: ['000000', '00FFFF'], max: 366}, 'check');
  //print('Scale'+String(startYear), scal )

  // Stack One layer by year 
  //
  var stackCollection = function(collection) {
    // Create an initial image.
    var first = ee.Image(collection.first()).select([]);

    // Write a function that appends a band to an image.
    var appendBands = function(image, previous) {
        var dateString = ee.Date(image.get('system:time_start')).format('yyyy-MM-dd');
        return ee.Image(previous).addBands(image);
    };
    return ee.Image(collection.iterate(appendBands, first));
  };

  var evi_img = stackCollection(burned_area);
  //print("EVI image stack",evi_img);

  Export.image.toDrive({
    image: evi_img,
    description: 'BurnedAreaAmazon'+String(startYear),
    scale: scale,
    region: congo,
    fileFormat: 'GeoTIFF',
    formatOptions: {
      cloudOptimized: true
    }
  });
}

