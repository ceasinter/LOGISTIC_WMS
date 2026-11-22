@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Product - Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_producto_lw
  provider contract transactional_query
  as projection on zr_product_lw
{
  key ProductUUID,
      ProductCode,
      @Semantics.text: true
      ProductName,
      Description,
      @Semantics.unitOfMeasure: true
      @ObjectModel.text.element: ['BaseUnitName']
      BaseUnit,
      _BaseUnit.UnitName as BaseUnitName,
      Barcode,
      IsActive,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      //      ASOCIACIONES
      _BaseUnit : redirected to zc_units_meas
}
