module GossipHelper
  include GeolocationHelper
  def nearby_gossip
    Gossip.all.filter { |gossip| within_50_meters?(gossip, current_user) }
  end
end
