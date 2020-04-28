module FacilitiesHelper
  def facility(facility)
    Facility.find(facility.facility_id).description
  end
end
