class Fluent::GeoBlipperOutput < Fluent::BufferedOutput
  Fluent::Plugin.register_output('geoblipper', self)

  def initialize
    super
    require 'geoip'
    require 'pubnub'
  end

  config_param :pubnub_channel, :string
  config_param :pubnub_publish_key, :string
  config_param :pubnub_subscribe_key, :string
  config_param :geodata_location, :string
  config_param :max_entries, :integer, :default => -1
  config_param :ip_key, :string, :default => 'ip'
  config_param :extra_capture, :array, :default => []

  def start
    super
    @geodata = GeoIP.new(@geodata_location)
    @pubnub = Pubnub.new( publish_key: @pubnub_publish_key, subscribe_key: @pubnub_subscribe_key )
  end

  def format(tag, time, record)
    address = record[@ip_key]
    loc = @geodata.city(address)
    extra = {}
    extra_capture.each do |key|
      extra[key] = record[key]
    end
    if loc
      {latitude: loc.latitude, longitude: loc.longitude}.merge(extra).to_json + "\n"
    else
      ""
    end
  end

  def write(chunk)
    chunk.open do |io|
      items = io.read.split("\n")
      entries = items.slice(0..@max_entries).map {|item| JSON.parse(item) }
      unless entries.empty?
        @pubnub.publish(http_sync: true, message: entries, channel: @pubnub_channel)
      end
    end
  end
end
