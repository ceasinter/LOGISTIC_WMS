@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Type - Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_stock_type
  provider contract transactional_interface
  as projection on zr_stock_type
{
  key StockTypeUUID,
      StockTypeCode,
      StockTypeName,
      Description,
      IsPickable,
      RequiresQuality,
      IsBlocked,
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
