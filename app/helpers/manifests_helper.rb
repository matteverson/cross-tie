module ManifestsHelper
  def self.total_cost
    tc = self.quantity * self.unit_cost
    return tc
  end
end
