# Smell: Simplifying Conditional Expressions

# Refactoring: Replace Conditional with Polymorphism
class MountainBike
  def initialize(base_price, front_suspension_price, rear_suspension_price, commission)
    @base_price = base_price
    @front_suspension_price = front_suspension_price
    @rear_suspension_price = rear_suspension_price
    @commission = commission
  end

  def price(code)
    case code
    when :rigid
      (1 + @commission) * @base_price
    when :front_suspension
      (1 + @commission) * @base_price + @front_suspension_price
    when :full_suspension
      (1 + @commission) * @base_price + @front_suspension_price + @rear_suspension_price
    end
  end
end

giant_pro_29er = MountainBike.new 20000, 4000, 6000, 0.1
puts giant_pro_29er.price(:rigid)
puts giant_pro_29er.price(:front_suspension)
puts giant_pro_29er.price(:full_suspension)

# Replace Conditional with Polymorphism

class MountainBike
  attr_reader :base_price, :commission, :front_suspension_price, :rear_suspension_price
  def initialize(base_price, front_suspension_price, rear_suspension_price, commission)
    @base_price = base_price
    @front_suspension_price = front_suspension_price
    @rear_suspension_price = rear_suspension_price
    @commission = commission
  end

  def price(klass)
    klass.new(base_price, front_suspension_price, rear_suspension_price, commission).price
  end
end

class RigidMountainBike < MountainBike
  def price
    (1 + commission) * base_price
  end
end

class FrontSuspensionMountainBike < MountainBike
  def price
    (1 + commission) * base_price + front_suspension_price
  end
end

class FullSuspensionMountainBike < MountainBike
  def price
    (1 + commission) * base_price + front_suspension_price + rear_suspension_price
  end
end

giant_pro_29er = MountainBike.new 20000, 4000, 6000, 0.1
puts giant_pro_29er.price(RigidMountainBike)
puts giant_pro_29er.price(FrontSuspensionMountainBike)
puts giant_pro_29er.price(FullSuspensionMountainBike)

# reek simplifying_conditional_expressions-06.rb
