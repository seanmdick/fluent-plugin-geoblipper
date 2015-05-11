# fluent-plugin-geoblipper
A fluentd plugin to send a buffered list of lat/long pairs to pubnub.

## Configuration
* **pubnub_channel** [*string*] Channel to publish to (**REQUIRED*)
* **pubnub_publish_key** [*string*] Pubnub publishing key (**REQUIRED*)
* **pubnub_publish_key** [*string*] Pubnub subscription key (**REQUIRED*)
* **geodata_location** [*string*] Absolute path to maxmind GeoIP database (**REQUIRED*)
* **max_entries** [*integer*] Maximum number of lat/long pairs to publish at each flush
* **ip_key** [*string*] Key to retrieve IP Address from each inbound record (*default: **ip***)

Example configuration:

        <match foo.bar>
            type geoblipper
            pubnub_channel something_good
            pubnub_publish_key pub-c-ABCDE-FGHIJK
            pubnub_subscribe_key sub-c-ABCDE-FGHIJK
            geodata_location /etc/geo/GeoIPCity.dat
            max_entries 30
            ip_key host
        </match>
