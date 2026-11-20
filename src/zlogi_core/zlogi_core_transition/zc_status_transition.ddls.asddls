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
      IsAllowed,
      
      _FromStatus.StatusDescription as FromStatusDescription,
      _ToStatus.StatusDescription   as ToStatusDescription,
      
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
      _FromStatus : redirected to zc_status,
      _ToStatus   : redirected to zc_status
}
