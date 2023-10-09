class Cover < ApplicationRecord
    def get_data
        url = 'https://catalog.tadl.org/osrf-gateway-v1?service=open-ils.search&method=open-ils.search.biblio.record.mods_slim.retrieve&locale=en-US&param=' + self.record_id.to_s
        puts url
        record_details = JSON.parse(open(url).read)
        if record_details["payload"][0]['__p']
            self.title = record_details['payload'][0]['__p'][0]
            self.artist = record_details['payload'][0]['__p'][1]
            self.record_id = record_details['payload'][0]['__p'][2]
            self.release_date = record_details['payload'][0]['__p'][4]
            self.abstract = record_details['payload'][0]['__p'][13]
            self.publisher = record_details['payload'][0]['__p'][6]
            self.track_list = record_details['payload'][0]['__p'][15]
            self.item_type = record_details['payload'][0]['__p'][9][0]
            if self.valid?
                self.save!
                return true
            else
                return false
            end
        else
            return false
        end
    end
end
