@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Warehouse - Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_warehouse
  provider contract transactional_query
  as projection on zr_warehouse
{
      @ObjectModel.text.element: ['WarehouseName']
  key WarehouseUUID,
      WarehouseCode,
      @Semantics.text: true
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
      LocalLastChangedAt,

      //      ASOCIACIONES
      _StorageBin : redirected to composition child zc_storage_bin
}
