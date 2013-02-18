class Bicycle
  include Schedulable

  def lead_days
    1
  end

  attr_accessor :size, :tire_size, :chain

  def initialize(args={})
    @size = args[:size]
    @tire_size = args[:tire_size] || default_tire_size
    @chain = args[:chain] || default_chain

    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def spares
    { tire_size: tire_size,
      chain:     chain}.merge(local_spares)
  end

  def local_spares
    {}
  end

  def default_tire_size
    raise NotImplementedError
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def default_tire_size
    '23'
  end

  def local_spares
    {tape_color: tape_color}
  end
end

class MountainBike < Bicycle
  attr_accessor :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def default_tire_size
    '2.1'
  end
  
  def local_spares
    {front_shock: front_shock,
     rear_shock:  rear_shock}
  end
end

class RecumbentBike < Bicycle
  attr_accessor :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end

  def local_spares
    {flag:  flag}
  end
end
