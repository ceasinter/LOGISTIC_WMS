@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Status Transition - ProjView'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_status_transition
  provider contract transactional_query
  as projection on zr_status_transition
{
  key ProcessCode,
  key FromStatus,
  key ToStatus,
      IsActive,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      LocalChangedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalChangedAt
}
