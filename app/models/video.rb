require 'csv'

module YoutubeDL
  class Video

    def self.from_csv(file = nil)
      ids = videos_ids(file)
      client.videos(ids)
    end

    private

    def self.client
      @client ||= YouTubeIt::Client.new
    end

    def self.videos_ids(file)
      csv_content = CSV.parse(file)
      csv_content.shift

      [].tap do |videos|
        csv_content.each do |row|
          video_id = row[4].match(/(video:)(.*)/)[2]
          videos << video_id if video_id
        end
      end
    end

  end
end
