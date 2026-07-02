@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZDMO_R_TRAVEL
  as select from zdmo_a_travel_d
{
  key travel_uuid            as TravelUUID,
      travel_id              as TravelID,
      agency_id              as AgencyID,
      customer_id            as CustomerID,
      begin_date             as BeginDate,
      end_date               as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee            as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price            as TotalPrice,
      currency_code          as CurrencyCode,
      description            as Description,
      overall_status         as OverallStatus,
      @Semantics.user.createdBy: true
      local_created_by       as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at       as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by  as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt
}
