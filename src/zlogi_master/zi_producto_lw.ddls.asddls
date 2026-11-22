@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Product - Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_producto_lw
provider contract transactional_interface
  as projection on zr_product_lw
{
  key ProductUUID,
      ProductCode,
      @Semantics.text: true
      ProductName,
      Description,
      BaseUnit,
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
      LocalLastChangedAt
}
