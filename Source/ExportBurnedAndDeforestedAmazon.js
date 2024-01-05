// Cargar la FeatureCollection
var roi_fc = ee.FeatureCollection("users/arysar/amapoly_ivb");
var hansen = ee.Image('UMD/hansen/global_forest_change_2022_v1_10');

// Cargar la FeatureCollection
var roi_fc = ee.FeatureCollection("users/arysar/amapoly_ivb");

// Convertir la FeatureCollection en un objeto Geometry
var roi = roi_fc.geometry();

var modis = ee.ImageCollection('MODIS/061/MCD64A1');

// Definir una función para calcular las áreas para un año dado
function calculateAreas(year) {
  var year1 = ee.Number(year).toInt();
  //year = ee.Number(year).toInt();

  var modis_filtered = modis.filterDate(year1.format().cat('-01-01'), year1.format().cat('-12-31'));

  modis_filtered = modis_filtered.map(function(img) {return img.clip(roi)});
  
  var modis_fire = modis_filtered.select('BurnDate').reduce(ee.Reducer.max(), 16).gt(0);
  //Map.addLayer(modis_fire.updateMask(modis_fire), {palette: 'FF0000'}, 'Fuego ' + yeari.format());

  var loss = hansen.select('loss');
  var fire_deforestation = modis_fire.and(loss);

  var modis_projection = modis.first().select('BurnDate').projection();
  var modis_scale = modis_projection.nominalScale();
  var deforested_burned_area = fire_deforestation.multiply(ee.Image.pixelArea()).reduceRegion({
    reducer: ee.Reducer.sum(),
    geometry: roi,
    scale: modis_scale,
    maxPixels: 1e13
  });

  var deforested_area = ee.Number(loss.multiply(ee.Image.pixelArea()).reduceRegion({
    reducer: ee.Reducer.sum(),
    geometry: roi,
    scale: modis_scale,
    maxPixels: 1e13
  }).get('loss')).divide(1e6);


  // Calcular el área total quemada pero no deforestada en km²
  var burned_not_deforested_area = ee.Number(modis_fire.and(loss.not()).multiply(ee.Image.pixelArea()).reduceRegion({
    reducer: ee.Reducer.sum(),
    geometry: roi,
    scale: modis_scale,
    maxPixels: 1e13
  }).get('BurnDate_max')).divide(1e6);


  // Calcular el área total quemada pero no deforestada en km²
  var burned_area = ee.Number(modis_fire.multiply(ee.Image.pixelArea()).reduceRegion({
    reducer: ee.Reducer.sum(),
    geometry: roi,
    scale: modis_scale,
    maxPixels: 1e13
  }).get('BurnDate_max')).divide(1e6);


  var deforested_burned_area_km = ee.Number(deforested_burned_area.get('BurnDate_max')).divide(1e6)
  
     // Calcular el área total deforestada en km² para el año especificado
   var loss_year = hansen.select('lossyear').eq(ee.Number(year).subtract(2000));
   var annual_deforested_area = loss_year.multiply(ee.Image.pixelArea()).reduceRegion({
     reducer: ee.Reducer.sum(),
     geometry: roi,
     scale: modis_scale,
     maxPixels: 1e13
   });
   
   var annual_deforested_area_km = ee.Number(annual_deforested_area.get('lossyear')).divide(1e6);
  // Crear un diccionario con los resultados para el año especificado
  return {
    year: year,
    deforested_area: deforested_area,
    annual_deforested_area_km: annual_deforested_area_km,
    deforested_burned_area_km: deforested_burned_area_km,
    burned_not_deforested_area: burned_not_deforested_area,
    burned_area: burned_area
  };
}

// Generar una lista de años desde el 2001 al 2022
var years = ee.List.sequence(2001,2022);
// Calcular las áreas para cada año de la lista
var results = years.map(calculateAreas);

// Convertir la lista de resultados en una FeatureCollection
var results_fc = ee.FeatureCollection(results.map(function(result) {
   return ee.Feature(null, result);
}));

print(results_fc, "results_fc")

// Exportar la FeatureCollection a un archivo CSV en Google Drive
Export.table.toDrive({
   collection: results_fc,
   description: 'BurnedAndDeforestedAmazon',
   fileFormat: 'CSV'
});
