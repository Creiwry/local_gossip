# frozen_string_literal: true

module GeolocationHelper
  def within_50_meters?(point1, point2)
    if point1.latitude && point1.longitude && point2.latitude && point2.longitude
      lat1 = point1.latitude
      lon1 = point1.longitude
      lat2 = point2.latitude
      lon2 = point2.longitude

      radius_of_earth = 6371e3
      latitude1_rad = lat1 * Math::PI / 180
      latitude2_rad = lat2 * Math::PI / 180
      change_in_latitude_rad = (lat2 - lat1) * Math::PI / 180
      change_in_longitude_rad = (lon2 - lon1) * Math::PI / 180

      a = Math.sin(change_in_latitude_rad / 2)**2 +
          Math.cos(latitude1_rad) * Math.cos(latitude2_rad) *
          Math.sin(change_in_longitude_rad / 2)**2
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      distance = radius_of_earth * c

      distance <= 50
    else
      false
    end
  end
end
