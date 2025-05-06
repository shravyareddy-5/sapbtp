@EndUserText.label: 'cds view for odata service'
@ObjectModel: {
query: {
implementedBy: 'ABAP:ZCONS_ODATA_S4'
}
}
define custom entity zcds_odata_cons
 
{
  @UI.lineItem: [{ position:10 }]
key Product : abap.char( 10 );
ProductType : abap.char( 2 );
@UI : {
lineItem : [{position: 20, importance: #HIGH}],
identification: [{position: 20}],
selectionField: [{position: 20}]
}
ProductCategory : abap.char( 40 );
@UI : {
lineItem : [{position: 30, importance: #HIGH}],

identification: [{position: 30}]
}
CreatedByUser:abap.char(10);
CreationDateTime:tzntstmpl;
LastChangedByUser:abap.char(10);
LastChangedDateTime:tzntstmpl;
@UI.lineItem: [{ position:20 }]
Price : abap.curr( 16, 2 );
@Semantics.currencyCode: true
Currency : abap.cuky;
@Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
@UI.lineItem: [{ position:40 }]
Height : abap.dec( 13, 3 );
@Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
Width : abap.dec( 13, 3 );
@Semantics.quantity.unitOfMeasure: 'DimensionUnit' 
@UI.lineItem: [{ position:50 }]
Depth : abap.dec( 13, 3 );
@Semantics.unitOfMeasure: true
DimensionUnit : abap.unit( 3 );
ProductPictureUrl : abap.char( 255 );
ProductValueAddedTax:abap.int1;
Supplier:abap.char(10);
ProductBaseUnit:abap.char(3);
Weight:abap.dec(13,3);
WeightUnit:abap.unit(3);
OriginalLanguage:abap.char(2);
}
