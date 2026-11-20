@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Warehouse - Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_warehouse
  provider contract transactional_interface
  as projection on zr_warehouse
{
  key WarehouseUUID,
      WarehouseCode,
      WarehouseName,
      Description,
      City,
      Country,
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
