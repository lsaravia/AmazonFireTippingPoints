// Define start and end ee.Dates.
var startDate = ee.Date('2000-01-01');
var endDate = ee.Date('2010-01-01');


// Load Amazonia Basin
var countries = ee.FeatureCollection("users/arysar/amapoly_ivb");

// Subset the to a Country .
var congo = ee.Feature(
  countries.first()
);

congo = congo.simplify(1);

// Load a FeatureCollection from a table dataset: 'RESOLVE' ecoregions.
var ecoregions = ee.FeatureCollection('RESOLVE/ECOREGIONS/2017');


// Subset o the bounds of the ecoregion feature
// and other criteria. Clip to the intersection with congo.
var protectedAreas = ecoregions
  .filter(ee.Filter.and(
    ee.Filter.bounds(congo.geometry()),
    ee.Filter.eq('BIOME_NUM', 1)             // 4 = TBMF AUstralia, 1=TMBF Amazonia
  ))
  .map(function(feat){
    return congo.intersection(feat,ee.ErrorMargin(1));
  });

// Map.addLayer(protectedAreas, {}, 'Eco region ');

var col =  ee.ImageCollection("MODIS/006/MCD64A1")
             .filterDate('2000-01-01', '2001-01-01')
             .select('BurnDate');

//print(fire)
// Clip and add a date band
var clipToRegion = function(img) {
  var clipped = img.clip(congo);
  return clipped;
};
             
var fire_clipped =col.map(clipToRegion)

var scale = fire_clipped.first().projection().nominalScale().getInfo();
var crs = fire_clipped.first().projection().crs();

Map.addLayer(fire_clipped.first(), {}, 'Fire clipped');

print('Scale',scale);

var rasterFootprint = ee.Image(1).clip(congo)
var areaImage = rasterFootprint.multiply(ee.Image.pixelArea());
// Sum the values of forest loss pixels in the Congo Republic.
var stats = areaImage.reduceRegion({
  reducer: ee.Reducer.sum(),
  geometry: countries,
  scale: scale,
  maxPixels: 1e9
});
print('Pixels representing: ', stats.get('constant'), 'square meters');

var stats1 = rasterFootprint.reduceRegion({
  reducer: ee.Reducer.sum(),
  geometry: countries,
  scale: scale,
  maxPixels: 1e9
});
print('Pixels no: ', stats1.get('constant'));



Map.addLayer(protectedAreas, {}, 'Eco region ');
Map.addLayer(rasterFootprint, {}, 'Raster Footprint');

Map.centerObject(protectedAreas)
Export.image.toDrive({
    image: rasterFootprint,
    description: 'BurnedAreaAmazon_rasterFootprint',
    scale: scale,
    region: congo,
    crs: crs,
    fileFormat: 'GeoTIFF',
    formatOptions: {
      cloudOptimized: true
    }
  });
