@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Type - Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_stock_type
  as select from zlogi_stock_type
{
  key stock_type_uuid       as StockTypeUUID,
      stock_type_code       as StockTypeCode,
      stock_type_name       as StockTypeName,
      description           as Description,
      is_pickable           as IsPickable,
      requires_quality      as RequiresQuality,
      is_blocked            as IsBlocked,
      is_active             as IsActive,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
