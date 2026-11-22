@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Storage Bin - Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_storage_bin
  provider contract transactional_interface
  as projection on zr_storage_bin
{
  key StorageBinUUID,
      WarehouseUUID,
      StorageTypeUUID,
      StorageBinCode,
      StorageBinName,
      AisleCode,
      RackCode,
      LevelCode,
      PositionCode,
      Description,
      IsActive,

      // CAMPOS DE AUDITORÍA
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
