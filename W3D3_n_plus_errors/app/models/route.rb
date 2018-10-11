class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

#  Route.first.buses
  # Route Load (0.6ms)  SELECT  "routes".* FROM "routes" ORDER BY "routes"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # Bus Load (1.9ms)  SELECT "buses".* FROM "buses" WHERE "buses"."route_id" = $1  [["route_id", 1]]
  def wrong_drivers_query
    buses = self
      .buses
      .select('buses.*')
      .joins(:drivers)
      .group('buses.id')

    # in SQL:
    #   SELECT buses.*, COUNT(*) AS counted_buses
    #   FROM buses
    #   JOINS drivers
    #   ON drivers.bus_id = #{self.id}
    #   GROUP BY buses.id

    # b.class
    # => Driver::ActiveRecord_Associations_CollectionProxy

    # what it looks like in the console:
    # Route
      # .first
      # .buses
      # .select('buses.*')
      # .joins(:drivers)
      # .group('buses.id')
      # .first
      # .drivers
    hash_count = {}
    buses.each do |bus|
      driver_count = []

      bus.drivers.each do |driver|
        driver_count << driver.name
      end

      hash_count[bus.id] = driver_count
    end
    hash_count

  end

  def better_drivers_query
    buses = self.buses.includes(:drivers)

    all_drivers = {}
    buses.each do |bus|
      drivers_count = []
      # will not fire a query for each route since drivers have already been prefetched
      bus.drivers.each do |driver|
        drivers_count << driver.name
      end
      all_drivers[bus.id] = drivers_count
    end

    all_drivers
  end
end
