@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Storage Bin - P View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_storage_bin
  //  provider contract transactional_query
  as projection on zr_storage_bin
{
  key StorageBinUUID,
      WarehouseUUID,
      @ObjectModel.text.element: ['StorageTypeName']
      StorageTypeUUID,
      StorageBinCode,
      StorageBinName,
      AisleCode,
      RackCode,
      LevelCode,
      PositionCode,
      Description,
      IsActive,

      //CAMPOS DE AUDITOÍA
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

      _StorageType.StorageTypeName as StorageTypeName,
      _Warehouse   : redirected to parent zc_warehouse,
      _StorageType : redirected to zc_storage_type

}
