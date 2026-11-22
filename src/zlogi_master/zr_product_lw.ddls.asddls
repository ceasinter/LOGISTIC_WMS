@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Product - Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_product_lw
  as select from zlogi_product

  association [0..1] to zr_units_meas as _BaseUnit on $projection.BaseUnit = _BaseUnit.UnitCode
{
  key product_uuid          as ProductUUID,
      product_code          as ProductCode,
      product_name          as ProductName,
      description           as Description,
      base_unit             as BaseUnit,
      barcode               as Barcode,
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
      local_last_changed_at as LocalLastChangedAt,

      //      ASOCIACIONES
      _BaseUnit
}
